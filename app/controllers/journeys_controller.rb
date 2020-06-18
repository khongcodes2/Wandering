class JourneysController < ApplicationController
    include SessionsHelper
    include JourneysHelper
    include SpacesHelper
    include ItemsHelper
    include Moderated
    include FormOptions

    before_action :set_journey, only:[:show, :edit, :update, :destroy]
    before_action :current_journey, only:[:drop_item, :pickup_item, :wrapup, :wrapup_cast, :wrapup_casting, :end_journey]
    before_action :select_item_and_continue, only:[:drop_item, :pickup_item]
    after_action :end_journey_actions, only: :end_journey

    def new
        # User can only create new journey if not already on journey
        if !session[:journey_id].present?

            traveler_label = current_user ? "Pick one of your travelers" : "Pick a free traveler"
            random_label = current_user ? "Randomly select one of your travelers" : "Randomly select a free traveler"

            @var_hash = {
                journey: Journey.new,
                traveler_options: [
                    FormOption.new(traveler_label, "selected traveler"),
                    FormOption.new(random_label, "random traveler"),
                    FormOption.new("Create a new traveler", "new traveler")
                ],
                available_travelers: current_user ? current_user.travelers : Traveler.no_user,
                region_options: (Region.all.collect {|region| FormOption.new(region.name, region.id)}).push(FormOption.new("Random region", "random")),
                regions: Region.all,
                starting_three: Item.starting_three
            }
        else
            @journey = Journey.find(session[:journey_id])
        end
    end

    def create
        @journey = Journey.new

        # only allow logged-in user to select from user's travelers
        # only allow no-login user to select from no-user travelers
        available_travelers = current_user ? current_user.travelers : Traveler.no_user
        
        # assign traveler: new OR random OR first in drop-down
        case journey_params[:traveler_option]
        when "new traveler"
            @journey.new_traveler(journey_params[:new_traveler])
        when "random traveler"
            @journey.traveler = available_travelers.sample
        when "selected traveler"
            @journey.traveler = Traveler.find(journey_params[:traveler_id])
        end
        # if journey_params[:traveler_option]=="new traveler"
        #     @journey.new_traveler(journey_params[:new_traveler])
        # elsif journey_params[:random_traveler_box]=="1"
        #     @journey.traveler = available_travelers.sample
        # else
        #     @journey.traveler = Traveler.find(journey_params[:traveler_id])
        # end
        
        # assign region: random OR first in drop-down
        # assign journey name: "traveler.name's journey" if blank
        # assign user (nil if none)
        # assign item to journey if an item is selected
        @journey.region = journey_params[:region_id]=="random" ? Region.all.sample : Region.find(journey_params[:region_id])
        @journey.name = journey_params[:name].present? ? journey_params[:name] : "#{@journey.traveler.name}'s journey"
        @journey.user = current_user
        @journey.items.push(Item.find(journey_params[:items])) unless journey_params[:items].nil?
        
        if @journey.traveler.save && @journey.save
            mod = Moderator.new
            mod.flag_if(@journey.traveler)
            mod.flag_if(@journey)

            # start journey, update parents (traveler and user)
            @journey.start
            @journey.traveler.user = current_user
            @journey.traveler.save
            
            # put it in session to indicate to browser we want journey UI, initialize array of fully-linked spaces to be pushed to
            session[:journey_id] = @journey.id
            session[:fully_linked_spaces]=[]
            redirect_to region_space_path(@journey.region, @journey.region.spaces.sample) and return
        else
            # save failed - prepare to reinitialize form
            @var_hash = {
                journey: @journey,
                traveler_label: current_user ? "Pick one of your travelers" : "Pick a free traveler",
                available_travelers: available_travelers,
                regions: Region.all,
                starting_three: Item.starting_three
            }
            render :new
        end
    end

    def index
        @journeys = Journey.last_10_completed
    end

    def continue
        # issue :continue token to prevent journey.tick_clock
        session[:continue] = true
        redirect_was_just_on
    end

    def show
    end

    def edit
        render '/layouts/permissions_error' and return unless currently_admin
    end

    def update
        # raise params.inspect
        @journey.assign_attributes(journey_params)
        @journey.assign_attributes(flag:false)
        if @journey.save
            Moderator.new.flag_if(@journey) unless currently_admin
        end
        redirect_to control_panel_path
    end

    def destroy
        delete_journey_drop_items(@journey) if @journey.clock != 10
        @journey.destroy
        redirect_to control_panel_path
    end


    ########################################################
    ########      sections for item handling        ########
    ########################################################

    def drop_item
        # if journey HAS this item (therefore able to drop it)
        if @journey.items.include?(@item)
            # memory creation handled in Items helper so drop_all can also access it
            drop_item_here(@item)
            flash[:notice] = "Dropped #{@item.name}"
        end

        # if journey is in wrapup go to wrapup
        # else redirect was_just_on
        if session[:wrapup].present?
            redirect_to where_do_i_go_integer(session[:wrapup])
        else
            redirect_was_just_on
        end
    end

    def pickup_item
        # if on same space as item
        if space_was_just_on == @item.space
            if @journey.items.count>=4
                flash[:notice] = "You can't carry more than 4 items!"
            else
                memory = Memory.new(mem_type:'item_pickup', journey_id:@journey.id, item_id:@item.id, space_id:@item.space.id)
                memory.save
                @journey.traveler.pickup(@item)
                flash[:notice] = "Picked up #{@item.name}"
            end
        end
        redirect_was_just_on
    end

    ########################################################
    ######      sections for end-journey process      ######
    ########################################################

    def enter_wrapup
        # raise params.inspect
        # convenience-assign and read session[:wrapup] (or session[:wrapup] from sidebar End Journey button)
        wrapup = params.permit(:wrapup)[:wrapup]||session[:wrapup].to_s
        if wrapup == "1" || wrapup.empty?
            current_journey.update(clock:10)
            session[:wrapup] = 1
            redirect_to wrapup_path and return
        elsif wrapup =="2"
            redirect_to wrapup_cast_path and return
        else
            redirect_to root_path
        end
    end

    def wrapup
        # expect session[:wrapup] to be 1; else redirect
        redirect_to where_do_i_go_integer(session[:wrapup]) if session[:wrapup]!=1
    end

    def wrapup_cast
        # expect session[:wrapup] to be 2; else redirect
        redirect_to where_do_i_go_integer(session[:wrapup]) and return if session[:wrapup]!=2

        @items = @journey.items
        if session[:wrapup_resource_type] == "space"
            @resource = @journey.spaces.last
        elsif session[:wrapup_resource_type] == "item"
            @resource = @journey.items.last
        end
    end

    def wrapup_casting
        # expect session[:wrapup] to be 2; else redirect
        redirect_to where_do_i_go_integer(session[:wrapup]) and return if session[:wrapup]!=2
        
        # if user selected item, unspace and unjourney the item and save to cast;
        # else save "nothing" to cast
        if params.permit(:item)[:item].present?
            item = Item.find(params.permit(:item)[:item].to_i)
            @journey = Journey.find(session[:journey_id])
            @journey.items.delete(item)
            
            item.space = nil
            session[:cast] = item.name
        else
            session[:cast] = "nothing"
        end
        session[:wrapup] = 3
        redirect_to end_journey_path
    end

    def end_journey
        # expect session[:wrapup] to be 3; else redirect
        redirect_to where_do_i_go_integer(session[:wrapup]) and return if session[:wrapup]!=3

        @journey_name = @journey.name
        @traveler = @journey.traveler.name
        @items = @journey.items
        @cast = session[:cast]
        @journey.update(completed:true)
        @space = Space.find(session[:was_just_on])

        # create end memory
        memory = Memory.new(mem_type:'end')
        memory.journey = @journey
        memory.space = @space
        if session[:cast] != "nothing"
            memory.item = Item.last
        end
        memory.save
    end

    private

    def journey_params
        params.require(:journey).permit(
            :traveler_option, :traveler_id,
            :region_id,
            :name,
            :items,
            new_traveler:[
                :name,
                :descript
            ]
        )
    end

    def select_item
        @item = Item.find(params.permit(:items)[:items].to_i)
    end

    def set_journey
        @journey = Journey.find(params[:id])
    end

    def select_item_and_continue
        session[:continue] = true
        select_item
    end

    def redirect_was_just_on
        redirect_to region_space_path(current_journey.region, session[:was_just_on])
    end

    def end_journey_actions
        drop_all
        clear_journey
    end

end