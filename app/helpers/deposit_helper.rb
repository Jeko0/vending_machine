module DepositHelper 
  ALLOWED_COINS = [5, 10, 20, 50, 100]

  private 

  def validate_coin
    return if ALLOWED_COINS.any? { |coin| coin == params[:give_coin].to_i }

    render json: {
      errors: 'invalid type of coin'
    }, status: :unprocessable_entity
  end

  def set_product
    @product = Product.find_by(id: params[:product_id])

    return if @product

    render json: {
      errors: 'Product not found'
    }, status: 404
  end

  def check_user_role
    return if @user.buyer?

    render json: {
      errors: 'you are not qualified for this action'
    }, status: :unauthorized
  end

  def sign_in_user!
    return if @user

    render json: {
      errors: 'you must be logged in'
    }, status: :unauthorized
  end
end