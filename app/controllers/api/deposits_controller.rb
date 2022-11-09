# frozen_string_literal: true

module Api
  class DepositsController < ApplicationController
    include UserAuthentication
    include DepositHelper

    before_action :set_user, :sign_in_user!, :check_user_role
    before_action :set_product, only: :buy
    before_action :validate_coin, only: :update

    def show
      render json: {
        message: 'Your wallet',
        deposit: @user.deposit
      }
    end

    def update
      @user.deposit += params[:give_coin].to_i

      if @user.save
        render json: {
          message: 'successfull',
          deposit: @user.deposit
        }
      else
        render json: {
          message: 'something went wrong',
          errors: @user.errors
        }
      end
    end

    def destroy
      @user.deposit = 0

      if @user.save
        render json: {
          message: 'updated',
          deposit: @user.deposit
        }
      else
        render json: {
          message: 'failed',
          errors: @user.errors
        }
      end
    end

    def buy
      amount = params[:amount].to_i

      cost = @product.cost

      total_price = amount * cost

      if change_deposit(total_price, amount)
        render json: {
          message: "bought: ",
          product: @product,
          total: total_price,
          change: change
        }
      else
        render json: {
          errors: 'not enough money in wallet',
          total_price: total_price,
          deposit: @user.deposit
        }, status: :unprocessable_entity
      end
    end

    private

    def change
      deposit = @user.deposit
      changes = []

      ALLOWED_COINS.reverse.each do |coin|
        count = deposit / coin
        deposit -= count * coin
        count.times do
          changes << coin
        end
      end

      changes
    end

    def change_amount(amount)
      return false if amount > @product.amount_available

      @product.amount_available -= amount
      @product.save
    end

    def change_deposit(total_price, amount)
      return false if total_price > @user.deposit || !change_amount(amount)

      @user.deposit -= total_price
      @user.save
    end
  end
end
