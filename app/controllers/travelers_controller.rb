class TravelersController < ApplicationController
  before_action :set_traveler, only: [:show, :edit, :update, :destroy]
  include SessionsHelper
  include ItemsHelper

  def index
    @travelers = Traveler.all
  end

  def show
  end

  def new
    @traveler = Traveler.new
  end

  def create
    @traveler = Traveler.new(traveler_params)
    @traveler.user = current_user
    if @traveler.save
      redirect_to traveler_path(@traveler)
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    @traveler.assign_attributes(traveler_params)
    if @traveler.save
      redirect_to traveler_path(@traveler)
    else
      render :edit
    end
  end

  def destroy
    drop_all if current_journey
    clear_journey
    @traveler.destroy
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