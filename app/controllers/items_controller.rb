class ItemsController < ApplicationController
  include SessionsHelper
  include Moderated

  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new

    # lock new-item process to journey-end process
    @item.errors.add(:base, "You don't have permission to create this resource right now.") unless session[:wrapup]==1
  end

  def create
    @item = Item.new(item_params)

    @item.descript = @item.adjective+" "+@item.noun if @item.descript.empty?

    # lock new-item process to journey-end process
    if session[:wrapup]!=1
      redirect_to new_item_path
    elsif @item.save
      Moderator.new.flag_if(@item)

      journey = Journey.find(session[:journey_id])
      journey.items.push(@item)

      memory = Memory.new(mem_type:'item_discovery', journey_id:session[:journey_id].to_i, item_id:@item.id, space_id:session[:was_just_on].to_i)
      memory.save

      session[:wrapup_resource_type] = "item"
      session[:wrapup] = 2
      redirect_to wrapup_cast_path
    else
      render :new
    end
  end

  def edit
    # ONLY ADMIN ACCESS
    render '/layouts/permissions_error' and return unless currently_admin
  end

  def update
    # ONLY ADMIN ACCESS
    @item.assign_attributes(item_params)
    @item.assign_attributes(flag:false)

    if @item.save
      # if admin makes change, do not flag
      Moderator.new.flag_if(@item) unless currently_admin
    end
    
    redirect_to control_panel_path
  end

  def destroy
    # ONLY ADMIN ACCESS
    @item.destroy
    redirect_to control_panel_path
  end

  private

  def item_params
    params.require(:item).permit(:noun,:adjective,:descript)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end