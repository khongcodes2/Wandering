class SpacesController < ApplicationController
  def index
    @region = Region.find(params[:region_id])
    @spaces = @region.spaces
  end

  def total_index
    @spaces = Space.all
  end
  
  def show
    @space = Space.find(params[:id])
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
      session[:wrapup_resource] = region_space_path(@space.region,@space)
      # session[:wrapup] = 2
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