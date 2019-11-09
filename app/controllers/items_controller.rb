class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    if session[:wrapup]!=1
      @item.errors.add(:base, "You don't have permission to edit this resource right now.")
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:noun,:adjective,:descript)
  end

end