module SpacesHelper
  # USED: Spaces#show
  # to get random links for each space that don't already have their 3 link slots filled
  def generate_space_links(int)
    current_journey.region.spaces.where.not(id:session[:fully_linked_spaces]).order('RANDOM()').limit(int).pluck(:id)
  end

  # USED: like constantly
  # important for navigating from space to space - retain memory of last entered space
  # to assign previous space as a link to a newly-enetered space
  # and to be able to return to previous space from viewing an item or region details
  def space_was_just_on
    space = Space.find(session[:was_just_on])
  end

  # USED: in Spaces controller, in memory creation
  # Try to use this only in Spaces actions/helpers as params[:id] is vaid for other resources
  def current_space
    if params[:region_id]
      space = Space.find(params[:id])
    # may need to remove this else condition
    else
      space = Space.find(params[:id])
    end
  end
  

  # session[:map] looks something like this
  # "(155.a189.a194)(189.a155.a170.a180)(170.a189.a200.a83)"

  # each parentheses represents a space
  # the first number is the space id
  # the numbers with 'a' in front of them are the spaces this space is linked to
  
  # each space has a from-link and 2 to-links except the first space, which has no from-link
  # it is desirable to make the first link the space that the traveler just came from

  # this system was created to create a persisted space-linking system that is not saved to database
  # this is so if multiple users are using this site at the same time, their routes and spaces don't affect others as they are generated
  # this also makes the world state persistent so you can backtrack through spaces

  def expanded_map
    session[:map].split(/\(|\)/).reject(&:empty?).map{|a|a.split(".")}
  end
  # return value will look like this
  # [["155","a189","a194"],["189","a155","a170","a180"],["170","a189","a200","a83"]]


  def current_space_in_map
    expanded_map.detect{|d|d[0]==current_space.id.to_s}
  end
  # return value will look like this
  # ["189","a155","a170","a180"]

  def remove_a(str)
    str.reverse.chomp("a").reverse
  end
  # remove leading 'a' from links in strings

  def space_fully_linked
    spaces_linked_in_spaces = expanded_map.flatten.map{|s|remove_a(s) if s[0]=="a"}.compact
    fully_linked = expanded_map.flatten.map{|s|remove_a(s) if s[0]=="a"}.compact.select{|a|spaces_linked_in_spaces.count(a)>=3}.uniq
  end
  # return value will look like this
  # ["155"]

end