module ProductHelper
  private 

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

  def sign_in_user!
    return if @user

    render json: {
      errors: ['You have to sign in first']
    }, status: :unauthorized
  end
end