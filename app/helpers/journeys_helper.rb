module JourneysHelper
  def where_do_i_go_integer(int)
    case int
    when 1
      wrapup_path
    when 2
      wrapup_cast_path
    when 3
      end_journey_path
    else
      root_path
    end
  end
  
  # just helps JourneysController know what class to check for last resource created
  def wrapup_cast_created(resource)
    if resource.class.name=="Space"
      link_to resource.name, region_space_path(resource.region,resource)
    elsif resource.class.name=="Item"
      link_to resource.name, item_path(resource)
    end
  end
end