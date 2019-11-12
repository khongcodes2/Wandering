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

    def current_journey
        if session[:journey_id].present? 
            @journey = Journey.find(session[:journey_id])
        else
            nil
        end
    end

    # checks if user has permission to edit traveler
    # only users can edit their own travelers
    # no-users and users can both edit no-user travelers
    def traveler_user_permission(traveler)
        !traveler.user.present? || current_user == traveler.user
    end

    # checks if user has permission to edit user
    def user_self_permission(user)
        current_user == user
    end

    def clear_journey
        session.delete :journey_id
        session.delete :wrapup
        session.delete :wrapup_resource_type
        session.delete :cast
        session.delete :was_just_on
        session.delete :map
        session.delete :fully_linked_spaces
    end

end