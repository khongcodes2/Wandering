class ItemsController < ApplicationController
  include Moderated

  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new

    # lock new-item process to journey-end process
    if session[:wrapup]!=1
      @item.errors.add(:base, "You don't have permission to edit this resource right now.")
    end
  end

  def create
    @item = Item.new(item_params)

    if @item.descript.empty?
      @item.descript = @item.adjective+" "+@item.noun
    end

    # lock new-item process to journey-end process
    if session[:wrapup]!=1
      redirect_to new_item_path
    elsif @item.save
      flag_if(@item)

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

  private

  def item_params
    params.require(:item).permit(:noun,:adjective,:descript)
  end

end