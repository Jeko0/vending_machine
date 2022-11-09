# frozen_string_literal: true

module Api
  class ProductsController < ApplicationController
    include UserAuthentication
    include ProductHelper

    before_action :set_user, :sign_in_user!, :identify_user, except: %i[index show]
    before_action :set_product, only: %i[show update destroy]
    before_action :check_seller, only: %i[update destory]

    def index
      @products = Product.includes(:seller).all
      render json: @products
    end

    def show
      render json: @product
    end

    def create
      @product = Product.new(product_params)
      @product.seller_id = @user.id

      if @product.save
        render json: {
          message: 'product created',
          product: @product
        }, status: :ok
      else
        render json: { message: 'something went wrong' }, status: :unprocessable_entity
      end
    end

    def update
      @product.update(product_params)
      render json: { message: 'product updated' }
    end

    def destroy
      @product.destroy
      render json: { message: 'product deleted' }
    end

    private

    def product_params
      params.require(:product).permit(:product_name, :amount_available, :cost)
    end
  end
end
