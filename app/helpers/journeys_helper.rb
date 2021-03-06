module JourneysHelper
  # USED: in Journeys wrapup actions
  # to redirect to correct path
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
  
  # USED: journeys/wrapup_cast view
  # just helps JourneysController know what class to check for last resource created
  def wrapup_cast_created(resource)
    if resource.class.name=="Space"
      link_to resource.name, region_space_path(resource.region,resource)
    elsif resource.class.name=="Item"
      link_to resource.name, item_path(resource)
    end
  end

  # USED: journeys/show view
  # link to traveler or handle if traveler has been deleted
  def show_journey_traveler_name(journey)
    if journey.traveler
      link_to journey.traveler.name, journey.traveler
    else
      content_tag(:span, "An empty portrait rests here.", class:"flavor")
    end
  end

  # USED: journeys/show view
  # flavor text if more than 10 journeys exist
  def index_journeys_if_more_than_10
    if Journey.all.count > 10
      "The text past this point fades beyond readability."
    end
  end
end