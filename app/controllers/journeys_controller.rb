class JourneysController < ApplicationController
    include SessionsHelper
    include JourneysHelper
    include SpacesHelper
    include ItemsHelper

    before_action :current_journey, only:[:drop_item, :pickup_item, :wrapup, :wrapup_cast, :wrapup_casting, :end_journey]
    before_action :select_item_and_continue, only:[:drop_item, :pickup_item]

    def new
        # User can only create new journey if not already on journey
        if !session[:journey_id].present?
            @var_hash = {
                journey: Journey.new,
                traveler_label: current_user ? "Pick one of your travelers" : "Pick a free traveler",
                available_travelers: current_user ? current_user.travelers : Traveler.no_user,
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
        if journey_params[:new_traveler_box]=="1"
            @journey.new_traveler(journey_params[:new_traveler])
        elsif journey_params[:random_traveler_box]=="1"
            @journey.traveler = available_travelers.sample
        else
            @journey.traveler = Traveler.find(journey_params[:traveler_id])
        end
        
        # assign region: random OR first in drop-down
        # assign journey name: "traveler.name's journey" if blank
        # assign user (nil if none)
        # assign item to journey if an item is selected
        @journey.region = journey_params[:random_region_box]=="1" ? Region.all.sample : Region.find(journey_params[:region_id])
        @journey.name = journey_params[:name].present? ? journey_params[:name] : "#{@journey.traveler.name}'s journey"
        @journey.user = current_user
        @journey.items.push(Item.find(journey_params[:items])) unless journey_params[:items].nil?
        
        if @journey.traveler.save && @journey.save
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
        @journey = Journey.find(params[:id])
    end


    ########################################################
    ########      sections for item handling        ########
    ########################################################

    def drop_item
        # if journey HAS this item (therefore able to drop it)
        if @journey.items.include?(@item)
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
        if session[:was_just_on] == @item.space.id.to_s
            if @journey.items.count>=4
                flash[:notice] = "You can't carry more than 4 items!"
            else
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
    end

    private

    def journey_params
        params.require(:journey).permit(
            :traveler_id, :random_traveler_box, :new_traveler_box,
            :region_id, :random_region_box,
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

    def select_item_and_continue
        session[:continue] = true
        select_item
    end

    def redirect_was_just_on
        redirect_to region_space_path(current_journey.region, session[:was_just_on])
    end

end