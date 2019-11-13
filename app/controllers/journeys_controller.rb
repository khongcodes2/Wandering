class JourneysController < ApplicationController
    include SessionsHelper
    include JourneysHelper

    before_action :current_journey, only:[:drop_item, :pickup_item, :wrapup, :wrapup_cast, :wrapup_casting, :end_journey]

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
        @journey.region = journey_params[:random_region_box]=="1" ? Region.all.sample : Region.find(journey_params[:region_id])
        # assign journey name; "traveler.name's journey" if blank
        @journey.name = journey_params[:name].present? ? journey_params[:name] : "#{@journey.traveler.name}'s journey"
        # assign user (nil if none)
        @journey.user = current_user
        # assign item to journey if an item is selected
        @journey.items.push(Item.find(journey_params[:items])) unless journey_params[:items].nil?
        
        if @journey.traveler.save && @journey.save
            # start journey
            @journey.start
            # updates parents - traveler and user
            @journey.traveler.user = current_user
            @journey.traveler.save
            
            # put it in session to indicate to browser we want journey UI
            session[:journey_id] = @journey.id
            # initialize array of no-random spaces to be pushed to
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
        @journeys = Journey.all
    end

    def show
        @journey = Journey.find(params[:id])
    end

    ########################################################
    ########      sections for item handling        ########
    ########################################################

    def drop_item
        item = Item.find(params.permit(:items)[:items].to_i)
        # if item is valid
        if @journey.items.include?(item)
            @journey.traveler.drop_item(item)
        end
        flash[:notice] = "Dropped #{item.name}"
        redirect_to where_do_i_go_integer(session[:wrapup]) and return if session[:wrapup].present?
        redirect_to region_space_path(@journey.region, session[:was_just_on])
    end

    def pickup_item
        item = Item.find(params.permit(:items)[:items].to_i)
        # if on same space as item
        if session[:was_just_on] == item.space.id.to_s
            if @journey.items.count>=4
                flash[:notice] = "You can't carry more than 4 items!"
            else
                @journey.traveler.pickup(item)
                flash[:notice] = "Picked up #{item.name}"
            end
            
        end
        redirect_to region_space_path(@journey.region, session[:was_just_on])
    end

    ########################################################
    ######      sections for end-journey process      ######
    ########################################################

    def enter_wrapup
        wrapup = params.permit(:wrapup)[:wrapup]||session[:wrapup]
        if wrapup == "1" || wrapup.empty? 
            session[:wrapup] = 1
            redirect_to wrapup_path and return
        elsif wrapup =="2"
            redirect_to wrapup_cast_path and return
        else
            redirect_to root_path
        end
    end

    def wrapup
        redirect_to where_do_i_go_integer(session[:wrapup]) if session[:wrapup]!=1
    end

    def wrapup_cast
        @items = @journey.items
        if session[:wrapup_resource_type] == "space"
            @resource = @journey.spaces.last
        elsif session[:wrapup_resource_type] == "item"
            @resource = @journey.items.last
        end
        redirect_to where_do_i_go_integer(session[:wrapup]) if session[:wrapup]!=2
    end

    def wrapup_casting
        if session[:wrapup]!=2
            redirect_to where_do_i_go_integer(session[:wrapup]) and return
        else
            # if user selected item
            if params.permit(:item)[:item].present?
                item = Item.find(params.permit(:item)[:item])
                @journey = Journey.find(session[:journey_id])
                @journey.items.delete(item)
                
                # unspace the item
                item.space = nil
                # save it to session
                session[:cast] = item.name
            else
                # if no item selected
                session[:cast] = "nothing"
            end
            session[:wrapup] = 3
            redirect_to end_journey_path and return
        end
    end

    def end_journey
        if session[:wrapup]!=3
            redirect_to where_do_i_go_integer(session[:wrapup]) and return
        else 
            @journey_name = @journey.name
            @traveler = @journey.traveler.name
            @items = @journey.items
            @cast = session[:cast]
            @journey.update(completed:true)
            @space = Space.find(session[:was_just_on])
            clear_journey
        end
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

end