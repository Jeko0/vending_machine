# frozen_string_literal: true

module Api
  module Users
    class SessionsController < ApplicationController
      def create
        @user = User.find_by(user_name: user_params[:user_name])

        if @user&.valid_password?(user_params[:password])
          respond_with(@user)
        else
          render json: { error: 'incorrect email or password' }, status: :unauthorized
        end
      end

      private

      def user_params
        params.require(:user).permit(:user_name, :password)
      end

      def respond_with(_resource, _options = {})
        render json: {
          message: 'logged in Successfully',
          user: @user
        }, status: :ok
      end
    end
  end
end
