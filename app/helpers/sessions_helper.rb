module SessionsHelper
    def already_logged_in
        if session[:user_id]
            redirect_to :root
        end
    end

    def current_user
        if session[:user_id].present? 
            @user = User.find(session[:user_id])
        else
            nil
        end
    end

    def traveler_user_permission(traveler)
        !traveler.user.present? || current_user == traveler.user
    end

    def user_self_permission(user)
        current_user == user
    end

end