class SessionsController < ApplicationController
    include SessionsHelper
    
    before_action :already_logged_in, only: :login

    def home
    end
    
    def login
    end

    def create
        @user = User.find_by(username:login_params[:username])||User.new
        return head(:forbidden) unless @user.authenticate(login_params[:password])
        session[:user_id] = @user.id
        redirect_to :root
    end

    def destroy
        session.delete :user_id
        redirect_to :root
    end

    private

    def login_params
        params.require(:user).permit(:username,:password)
    end

end