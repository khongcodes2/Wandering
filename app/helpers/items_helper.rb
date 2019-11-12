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
end
