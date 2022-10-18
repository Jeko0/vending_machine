# frozen_string_literal: true

module Api
  module Users
    class RegistrationsController < ApplicationController
      before_action :set_user, only: %i[update destroy]

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordNotUnique, with: :try_again

      def create
        @user = User.new(user_params)

        if @user.save
          respond_with(@user)
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          respond_with(@user)
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        render json: { message: 'account deleted' }, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :role)
      end

      def set_user
        @user = User.find(params[:id])
      end

      def not_found
        render json: { error: 'not found' }, status: :not_found
      end

      def try_again
        render json: { error: 'name is taken, please try different name' }, status: :not_found
      end

      def respond_with(resource, _options = {})
        register_success && return if resource.persisted?

        register_failed
      end

      def register_success
        render json: {
          message: 'Sign up Successfully',
          user: @user
        }, status: :ok
      end

      def register_failed
        render json: { message: 'Something went wrong' }, status: :unprocessable_entity
      end
    end
  end
end
