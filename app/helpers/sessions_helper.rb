module SessionsHelper
    # USED: sessions and users controllers
    # prevent user from logging in or creating user if already logged in
    def already_logged_in
        if session[:user_id]
            redirect_to :root
        end
    end

    # USED: Journeys#create, Travelers#create, check user permission, layouts
    # check who is current user
    # affect layout, traveler/journey creation, edit permissions
    def current_user
        if session[:user_id].present? 
            @user = User.find(session[:user_id])
        else
            nil
        end
    end

    # USED: in controllers to check permissions and clear flags
    def currently_admin
        session[:user_id].present? && User.find(session[:user_id]).admin
    end
    
    # USED: almost everywhere
    # displays sidebar, affects if items can be picked up or dropped
    def current_journey
        if session[:journey_id].present? 
            @journey = Journey.find(session[:journey_id])
        else
            nil
        end
    end

    # USED: Travelers#show, Travelers#edit
    # checks if user has permission to edit traveler
    # only users can edit their own travelers
    # no-users and users can both edit no-user travelers
    def traveler_user_permission(traveler)
        !traveler.user.present? || current_user == traveler.user
    end

    # USED: Users#show, Users#edit
    # checks if user has permission to edit user
    def user_self_permission(user)
        if session[:user_id].present? 
            this_user = User.find(session[:user_id])
        else
            nil
        end
        this_user == user
    end

    # USED: Sessions#logout, Traveler#destroy, end journey
    # clear the board, clear session so new journey data can be held
    def clear_journey
        session.delete :journey_id
        session.delete :continue
        session.delete :wrapup
        session.delete :wrapup_resource_type
        session.delete :cast
        session.delete :was_just_on
        session.delete :map
        session.delete :fully_linked_spaces
    end

end