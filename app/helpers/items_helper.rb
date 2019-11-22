module ItemsHelper
  def item_space?
    if session[:journey_id].present? && Journey.find(session[:journey_id]).items.include?(@item)
      "In posession of #{Journey.find(session[:journey_id]).traveler.name}, at #{Space.find(session[:was_just_on]).name}"
    elsif @item.space.present?
      link_to @item.space.name, region_space_path(@item.space.region_id, @item.space)
    else
      "The Ether"
    end
  end

  def current_space_for_item_drop
      if params[:region_id]
        space = params[:id]
    else
        space = space_was_just_on
    end
  end

  def drop_item_here(item)
    current_journey.items.delete(item)
    current_space_for_item_drop.items.push(item)
  end

  def drop_all
    space = current_space_for_item_drop
    current_journey.items.each do |i|
      current_journey.items.delete(i)
      space.items.push(i)
    end
  end

end
