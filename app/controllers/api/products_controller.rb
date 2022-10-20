# frozen_string_literal: true

module Api
  class ProductsController < ApplicationController
    include UserAuthentification

    before_action :set_product, only: %i[show update destroy]
    before_action :find_user, only: %i[create update destroy]
    before_action :identify_user, only: %i[create update destroy]
    before_action :require_user_sign_in!, only: %i[create update destroy]
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

    def set_product
      return if @product = Product.includes(:seller).find_by(id: params[:product_id])

      render json: { error: 'product not found' }
    end

    def identify_user
      return if @user&.seller?

      render json: {
        errors: ['You have to be seller']
      }, status: :unauthorized
    end

    def check_seller
      return if @product.seller_id == @user.id
    end

    def require_user_sign_in!
      return if @user

      render json: {
        errors: ['You have to sign in first']
      }, status: :unauthorized
    end
  end
end
