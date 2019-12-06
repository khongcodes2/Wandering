class UsersController < ApplicationController
    include SessionsHelper
    include Moderated

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :already_logged_in, only: :new
    
    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flag_if(@user)
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
    end

    def edit
        render '/layouts/permissions_error' and return unless (user_self_permission(@user)||currently_admin)
    end
    
    def update
        @user.assign_attributes(user_params)

        @user.assign_attributes(flag:false) if currently_admin

        if @user.save
            flag_if(@user)
            redirect_to user_path(@user) and return
        else
            render :edit
        end
    end

    def destroy
        @user.destroy
        redirect_to users_path
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end
end