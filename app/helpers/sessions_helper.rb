module SessionsHelper
    def already_logged_in
        if session[:user_id]
            redirect_to :root
        end
    end

    def current_user
        @user = User.find(session[:user_id])
    end

end