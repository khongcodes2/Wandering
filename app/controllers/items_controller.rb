class ItemsController < ApplicationController
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

    # lock new-item process to journey-end process
    if session[:wrapup]!=1
      redirect_to new_item_path
    elsif @item.save
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