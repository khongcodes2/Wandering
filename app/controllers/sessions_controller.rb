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

    def omniauth_create
        @user = User.find_or_create_by(id:auth[:uid]) do |u|
            u.username = auth[:info][:name]
            u.password = auth[:info][:name]
        end
        session[:user_id] = @user.id
        redirect_to :root
    end

    def destroy
        clear_journey
        current_journey.traveler.drop_all if current_journey
        session.delete :user_id
        redirect_to :root
    end

    private

    def login_params
        params.require(:user).permit(:username,:password)
    end

    def auth
        request.env['omniauth.auth']
    end

end