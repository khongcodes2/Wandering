class TravelersController < ApplicationController
  include SessionsHelper
  include ItemsHelper
  include Moderated

  before_action :set_traveler, only: [:show, :edit, :update, :destroy]

  def index
    @travelers = Traveler.all
  end

  def show
    item_ids = (@traveler.memories - @traveler.memories.where(item_id:nil)).pluck(:item_id).uniq
    @items = Item.find(item_ids)
  end

  def new
    @traveler = Traveler.new
  end

  def create
    @traveler = Traveler.new(traveler_params)
    @traveler.user = current_user
    if @traveler.save
      flag_if(@traveler)
      redirect_to traveler_path(@traveler)
    else
      render :new
    end
  end

  def edit
    render '/layouts/permissions_error' and return unless (traveler_user_permission(@traveler)||currently_admin)
  end
  
  def update
    @traveler.assign_attributes(traveler_params)

    @traveler.assign_attributes(flag:false) if currently_admin

    if @traveler.save
      flag_if(@traveler)
      
      # IF TRAVELER NAME CHANGE, also change journey names named after traveler
      @traveler.journeys.each {|j| j.update(name:"#{@traveler.name}'s journey") if j.name.match?(/\A.*'s journey/)}

      redirect_to control_panel_path and return if currently_admin
      redirect_to traveler_path(@traveler) and return
    else
      render :edit
    end
  end

  def destroy
    drop_all if current_journey
    clear_journey
    @traveler.destroy
    redirect_to control_panel_path and return if currently_admin
    redirect_to root_path
  end

  private

  def traveler_params
    params.require(:traveler).permit(:name,:descript)
  end

  def set_traveler
    @traveler = Traveler.find(params[:id])
  end

end