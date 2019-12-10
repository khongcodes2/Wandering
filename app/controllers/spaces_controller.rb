class SpacesController < ApplicationController
  include SessionsHelper
  include SpacesHelper
  include Moderated

  before_action :set_space, only: [:edit, :update, :destroy]

  def index
    @region = Region.find(params[:region_id])
    @spaces = @region.spaces
  end

  def total_index
    @spaces = Space.all
  end
  
  def show
    @space = current_space
    if current_journey
      if current_journey.clock == 10 && !session[:continue]
        session[:wrapup] = 1 if !session[:wrapup].present?
        redirect_to enter_wrapup_path and return
      end

      # if visited this space before? DON'T PUSH to session[:map]
      if @journey.spaces.include?(@space)
        # remove :continue token
        session.delete :continue if session[:continue]

        if expanded_map.any?{|a|a[0]==session[:was_just_on].to_s} && session[:was_just_on] != params[:id]
        # if so, make it the "from" link, and the other two the "to" links
          @from = session[:was_just_on]
          @to = current_space_in_map.find_all{|a|a[0]=="a"&&remove_a(a)!=session[:was_just_on].to_s}.map{|s|remove_a(s)}
        else
        # first link should be the original from link
          @from = current_space_in_map.find_all{|a|a[0]=="a"}.map{|s|remove_a(s)}[0]
            # "id" in string
          @to = current_space_in_map.find_all{|a|a[0]=="a"&&remove_a(a)!=@from}.map{|s|remove_a(s)}
            # "id"s in string
        end
        
      else
        # add this space to journey's spaces
        # this space is about to have all its linked defined - push to session[:fully_linked]
        @journey.spaces.push(@space)
        # session[:fully_linked_spaces] << @space.id

        # if start of journey
        if @journey.clock==0
          # initialize map
          @to = generate_space_links(2)
          session[:map] = "(#{params[:id]}.a#{@to[0].to_i}.a#{@to[1].to_i})"

          # create memory
          # because Journey has Spaces through Memories, this should automatically add to journey's spaces
          memory = Memory.new(mem_type:'begin')
          memory.journey = @journey
          memory.space = current_space
          memory.save

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
        @journey.tick_clock if !session[:continue] || session[:was_just_on] != params[:id]
        session.delete :continue if session[:continue]

        if @journey.clock == 9
          flash.now.notice = "You can feel your journey will end soon..."
        elsif @journey.clock == 10
          flash.now.notice = "You feel the tug of the Ether - you know now that your journey will end with your next step."
        end

      end
      
      # create memory for previous space if on journey and just entered this space from previous space
      if ((params[:region_id] && session[:was_just_on].present?) && session[:was_just_on] != params[:id]) && (!session[:wrapup].present?)
        memory = Memory.new(mem_type:'traveler_leave')
        memory.space = space_was_just_on
        memory.journey = current_journey
        memory.save
      end
      
      # values for views links
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
      Moderator.new.flag_if(@space)

      journey = Journey.find(session[:journey_id])
      journey.spaces.push(@space)

      # create last traveler_leave memory
      memory1 = Memory.new(mem_type:'traveler_leave')
      memory1.journey = current_journey
      memory1.space = space_was_just_on
      memory1.save

      # create space_discovery memory with new space
      memory = Memory.new(mem_type:'space_discovery')
      memory.journey = journey
      memory.space = @space
      memory.save

      session[:was_just_on] = @space.id
      session[:wrapup_resource_type] = "space"
      session[:wrapup] = 2
      redirect_to wrapup_cast_path
    else
      render :new
    end
  end

  def edit
    render '/layouts/permissions_error' and return unless currently_admin
  end

  def update
    # ONLY ADMIN ACCESS
    @space.assign_attributes(space_params)
    @space.assign_attributes(flag:false)

    if @space.save
      Moderator.new.flag_if(@space) unless currently_admin
    end
    redirect_to control_panel_path
  end

  def destroy
    # ONLY ADMIN ACCESS
    @space.destroy
    redirect_to control_panel_path
  end

  private

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    params.require(:space).permit(:noun,:adjective,:descript,:region_id)
  end
end

