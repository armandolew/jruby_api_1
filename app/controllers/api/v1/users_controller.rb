module API
  module V1
    class Api::V1::UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /users
      # GET /users.json
      def index
        @users = User.all
      end

      # GET /users/1
      # GET /users/1.json
      def show
      end

      # POST /users
      # POST /users.json
      def create
        @user = User.new(user_params)
        @user.generate_token
        @user.encrypt_password(user_params[:password])

        if @user.save
          render 'api/v1/users/show', status: :created
        else
          render 'api/v1/users/show', status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      # PATCH/PUT /users/1.json
      def update
        if @user.update(user_params)
          render :show, status: :ok, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1
      # DELETE /users/1.json
      def destroy
        @user.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
          params.require(:user).permit(:name, :last_name, :email, :phone, :password)
        end
    end
  end
end