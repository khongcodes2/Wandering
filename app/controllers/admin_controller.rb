class AdminController < ApplicationController
  
  def control_panel
    render 'layouts/permissions_error' and return unless session[:user_id].present? && User.find(session[:user_id]).admin

    @users = User.flagged
    @travelers = Traveler.flagged
    @journeys = Journey.flagged
    @items = Item.flagged
    @spaces = Space.flagged
  end
end