# not functional - Partials cannot access helper methods

module AdminHelper
  def test_method
    raise params.inspect
  end

  def faded
    content_tag(:span, "Text faded - no user", class:"flavor")
  end

  def user_link(i)
    link_to i.created_by_user.username, user_path(i.created_by_user)
  end

  def traveler_link(i)
    link_to "Traveler #{i.created_by_traveler.name}", traveler_path(i.created_by_traveler)
  end

  def user_or_traveler(i)
    if i.user.present?
      user_link(i)
    elsif i.traveler.present?
      traveler_link(i)
    else
      faded
    end
  end
  
  def created_obj_info(i)
    case i.class.to_s
    when 'Traveler'
      if i.user.present?
        user_link(i)
      else
        faded
      end

    when 'Journey'
      user_or_traveler(i)
    when 'Item'
      user_or_traveler(i)
    when 'Space'
      user_or_traveler(i)
    end
  end
  
end