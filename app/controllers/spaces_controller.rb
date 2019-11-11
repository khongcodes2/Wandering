class SpacesController < ApplicationController
  include SessionsHelper

  def index
    @region = Region.find(params[:region_id])
    @spaces = @region.spaces
  end

  def total_index
    @spaces = Space.all
  end
  
  def show
    @space = Space.find(params[:id])
    if current_journey
      if current_journey.clock == 10
        session[:wrapup] = 1
        redirect_to enter_wrapup_path and return
      end
      @journey.spaces.push(@space) unless @journey.spaces.include?(@space)
      
      two_random_spaces = @journey.region.spaces.where.not(id:@journey.spaces).order('RANDOM()').limit(2)
      @space1 = two_random_spaces[0]
      @space2 = two_random_spaces[1]
      @journey.tick_clock


    end
  end


  def new
    @space = Space.new(region_id:params[:region_id])
    
    # lock new-space process to journey-end process
    # validate space region exists
    if session[:wrapup]!=1
      @space.errors.add(:base, "You don't have permission to edit this resource right now.")
    elsif Region.exists?(params[:region_id])
      @region = Region.find(params[:region_id])
      @region_name = @region.name
    else
      @space.errors.add(:region, "does not exist")
      @region_name = ""
    end
  end

  def create
    @space = Space.new(space_params)
    
    # lock new-space process to journey-end process
    if session[:wrapup]!=1
      redirect_to "/regions/#{space_params[:region_id]}/spaces/new"
    elsif @space.save
      journey = Journey.find(session[:journey_id])
      journey.spaces.push(@space)
      session[:wrapup_resource_type] = "space"
      session[:wrapup] = 2
      redirect_to wrapup_cast_path
    else
      render :new
    end
  end

  private

  def space_params
    params.require(:space).permit(:noun,:adjective,:descript,:region_id)
  end
end