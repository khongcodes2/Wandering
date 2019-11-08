module ItemsHelper
  def item_space?
    if @item.space.present?
      link_to @item.space.name, region_space_path(@item.space.region_id, @item.space)
    else
      "The Ether"
    end
  end
end
