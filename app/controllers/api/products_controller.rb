module Api 
  class ProductsController < ApplicationController
    include UserAuthentification

    before_action :set_product, only: [:update, :destroy]
    before_action :find_user, only: [:create, :update, :destroy]
    before_action :identify_user, only: [:create, :update, :destroy]
    before_action :check_seller, only: [:update, :destory]
    
    def index 
      @products = Product.all 
      render json: @products
    end
    
    def create 
      @product = Product.new(product_params)
      @product.seller_id = @user.id 
      
      if @product.save 
        render json: {
          message: "product created", 
          product: @product
        }, status: :ok
      else
        render json: {message: "something went wrong"}, status: :unprocessable_entity
      end
    end

    def update 
      @product.update(product_params)
      render json: { message: "product updated" }
    end

    def destroy
      @product.destroy 
      render json: { message: "product deleted" }
    end

    private 

    def product_params 
      params.require(:product).permit(:product_name, :amount_available, :cost)
    end

    def set_product 
      @product = Product.find_by(id: params[:id])
    end

    def identify_user
      return if @user&.seller?
    end

    def check_seller 
      return if @product.seller_id == @user.id  
    end
  end
end