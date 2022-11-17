# frozen_string_literal: true

module Api
  module Users
    class RegistrationsController < ApplicationController
      include AccessToken
      include UserAuthentication

      before_action :set_user, only: %i[update destroy]
      before_action :valid_user?, only: %i[update destroy]
      rescue_from JWT::DecodeError, with: :invalid_token

      def create
        @user = User.new(user_params)

        if @user.save
          respond_with(@user)
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user&.update(user_params)
          render json: { message: 'updated', user: @user, accessToken: AccessToken.encode(user_id: @user.id) }
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @user&.destroy
          render json: { message: 'account deleted' }, status: :ok
        else
          render json: { message: 'failed', errors: @user ? @user.errors : "couldn't find user" }
        end
      end

      private

      def user_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :role)
      end

      def invalid_token
        render json: { message: 'invalid token' }, status: :unauthorized
      end

      def respond_with(resource, _options = {})
        register_success && return if resource.persisted?

        render json: { message: 'Something went wrong', errors: @user.errors }, status: :unprocessable_entity
      end

      def register_success
        render json: {
          message: 'Signed up Successfully',
          user: @user,
          accessToken: AccessToken.encode(user_id: @user.id)
        }, status: :ok
      end

      def valid_user?
        return if @user&.valid_password?(params[:user][:password])

        render json: {
          errors: 'password required'
        }, status: :unprocessable_entity
      end
    end
  end
end
