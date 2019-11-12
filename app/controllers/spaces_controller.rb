class SpacesController < ApplicationController
  include SessionsHelper
  include SpacesHelper

  def index
    @region = Region.find(params[:region_id])
    @spaces = @region.spaces
  end

  def total_index
    @spaces = Space.all
  end
  
  def show
    @space = Space.find(params[:id])
    if current_journey
      if current_journey.clock == 10
        session[:wrapup] = 1
        redirect_to enter_wrapup_path and return
      end
      # visited this space before?
      # DON'T PUSH to space[:map]
      if @journey.spaces.include?(@space)
        # does session[:was_just_on] correspond to any of the links?
        if expanded_map.any?{|a|a[0]==session[:was_just_on].to_s}
        # if so, make it the "from" link, and the other two the "to" links
          @from = session[:was_just_on]
          @to = current_space_in_map.find_all{|a|a[0]=="a"&&remove_a(a)!=session[:was_just_on].to_s}.map{|s|remove_a(s)}
        else
        # if not, make to3
          @from = current_space_in_map.find_all{|a|a[0]=="a"}.map{|s|remove_a(s)}[0]
            # "id" in string
          @to = current_space_in_map.find_all{|a|a[0]=="a"&&a[1..3]!=@from}.map{|s|remove_a(s)}
            # "id"s in string
        end
        
      else
        # add this space to journey's spaces
        @journey.spaces.push(@space)
        # add this space to no-random list
        session[:fully_linked_spaces].push(@space.id)

        #if start of journey
        if @journey.clock==0
          # initialize map
          @to = generate_space_links(2)
          session[:map] = "(#{params[:id]}.a#{@to[0].to_i}.a#{@to[1].to_i})"

        else

          # before generating random links, check to see if any space is referenced in the map 3 or more times
          # if so, add to no-random list
          if space_fully_linked.present?
            session[:fully_linked_spaces] << space_fully_linked[0].to_i
          end

          # use session[:was_just_on] to create from-link
          @from = session[:was_just_on]

          # check to see if session[:map] has references to current space besides the one just came from
          case expanded_map.select{|a|a.include?("a#{@space.id}")}.count
          when 0
            get_three = generate_space_links(3)
            @from = get_three[0]
            @to = get_three[1..2]
            @three_paths = true
          when 2
            #take the one that doesn't match the fromlink
            @to = [expanded_map.select{|a|a.include?("a#{@space.id}")}.select{|a|a[0]!=@from.to_s}[0][0]]
            #generate the other
            @to.push(generate_space_links(1)[0])
          when 3
            #take the two that don't match the fromlink
            @to = expanded_map.select{|a|a.include?("a#{@space.id}")}.select{|a|a[0]!=@from.to_s}.map{|s|s[0]}
          else
            @to = generate_space_links(2)
          end
          session[:map] << "(#{params[:id]}.a#{@from}.a#{@to[0]}.a#{@to[1]})"
        end
         
        # only tick if not backtracking
        @journey.tick_clock

        if @journey.clock == 9
          flash.now.notice = "You can feel your journey will end soon..."
        elsif @journey.clock == 10
          flash.now.notice = "You know now that your journey will end with your next step."
        end

      end
      
      # values for views
      @to_space1 = Space.find(@to[0])
      @to_space2 = Space.find(@to[1]) if @to[1].present?
      @from_space = Space.find(@from) if @from.present?
    end
  end


  def new
    @space = Space.new(region_id:params[:region_id])
    
    # lock new-space process to journey-end process
    # validate space region exists
    if session[:wrapup]!=1
      @space.errors.add(:base, "You don't have permission to edit this resource right now.")
    elsif Region.exists?(params[:region_id])
      @region = Region.find(params[:region_id])
      @region_name = @region.name
    else
      @space.errors.add(:region, "does not exist")
      @region_name = ""
    end
  end

  def create
    @space = Space.new(space_params)
    
    # lock new-space process to journey-end process
    if session[:wrapup]!=1
      redirect_to "/regions/#{space_params[:region_id]}/spaces/new"
    elsif @space.save
      journey = Journey.find(session[:journey_id])
      journey.spaces.push(@space)
      session[:was_just_on] = @space.id
      session[:wrapup_resource_type] = "space"
      session[:wrapup] = 2
      redirect_to wrapup_cast_path
    else
      render :new
    end
  end

  private

  def space_params
    params.require(:space).permit(:noun,:adjective,:descript,:region_id)
  end
end