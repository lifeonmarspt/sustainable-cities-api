# frozen_string_literal: true
module V1
  class UsersController < ApplicationController
    include ErrorSerializer
    include ApiUploads

    skip_before_action :authenticate, only: [:index, :show]
    load_and_authorize_resource class: 'User'

    before_action :set_user, only: [:update, :destroy]


    def update
      if @user.update(user_params)
        render json: { messages: [{ status: 200, title: "User successfully updated!" }] }, status: 200
      else
        render json: ErrorSerializer.serialize(@user.errors, 422), status: 422
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: { messages: [{ status: 201, title: 'User successfully created!' }] }, status: 201
      else
        render json: ErrorSerializer.serialize(@user.errors, 422), status: 422
      end
    end

    def destroy
      if @user.destroy
        render json: { messages: [{ status: 200, title: 'User successfully deleted!' }] }, status: 200
      else
        render json: ErrorSerializer.serialize(@user.errors, 422), status: 422
      end
    end

    private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        set_user_params = [:name, :email, :country_id, :password, :password_confirmation,
                           :city_id, :nickname, :institution, :position,
                           :twitter_account, :linkedin_account, :image]

        if @current_user.is_active_admin? || @current_user.is_active_publisher?
          set_user_params << [:is_active]
        end

        if @current_user.is_active_admin?
          set_user_params << [:role]
        end

        return_params         = params.require(:user).permit(set_user_params)
        return_params[:image] = process_file_base64(return_params[:image]) if return_params[:image].present?
        return_params
      end
  end
end
