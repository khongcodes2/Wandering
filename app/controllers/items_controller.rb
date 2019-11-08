class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    byebug
  end

  private

  def item_params
  end

end