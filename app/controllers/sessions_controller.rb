class SessionsController < ApplicationController
    include SessionsHelper
    include ItemsHelper
    include SpacesHelper
    
    before_action :already_logged_in, only: :login

    def home
    end
    
    def login
    end

    def create
        @user = User.find_by(username:login_params[:username])||User.new
        return head(:forbidden) unless @user.authenticate(login_params[:password])
        logged_in_and_root
    end

    def omniauth_create
        @user = User.find_or_create_by(uid:auth[:uid]) do |u|
            u.username = auth[:info][:name]
            u.password = auth[:info][:name]
        end
        logged_in_and_root
    end

    def destroy
        drop_all if current_journey
        clear_journey
        session.delete :user_id
        redirect_to :root
    end

    def about
    end

    private

    def login_params
        params.require(:user).permit(:username,:password)
    end

    def auth
        request.env['omniauth.auth']
    end

    def logged_in_and_root
        session[:user_id] = @user.id
        redirect_to :root
    end

end