class JourneysController < ApplicationController
    include SessionsHelper

    def new
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

        @available_travelers = current_user ? current_user.travelers : Traveler.no_user
        if journey_params[:new_traveler_box]=="1"
            @journey.new_traveler(journey_params[:new_traveler])
            if @journey.traveler.save
            else
                # reinitialize form to display New Traveler errors
                @regions = Region.all
                @starting_three = Item.starting_three
                render '/journeys/new' and return
            end
        elsif journey_params[:random_traveler_box]=="1"
            @journey.traveler = @available_travelers.sample
        else
            @journey.traveler = Traveler.find(journey_params[:traveler_id])
        end
        
        @journey.region = journey_params[:random_region_box]=="1" ? Region.all.sample : Region.find(journey_params[:region_id])
       
        # if left blank, traveler_name's journey
        @journey.name = journey_params[:name].present? ? journey_params[:name] : "#{@journey.traveler.name}'s journey"
        @journey.user = current_user
        # @journey not listed in @journey.user.journeys
        @journey.items.push(Item.find(journey_params[:items])) unless journey_params[:items].nil?
        
        if @journey.save
            # updates parents - traveler and user
            @journey.traveler.user = current_user
            @journey.traveler.save
            
            # start journey
            # put it in session to indicate to browser we want journey UI
            @journey.start
            session[:journey_id] = @journey.id
            redirect_to region_space_path(@journey.region, @journey.spaces.last)
        else
            render :new
        end
    end

    def index
        @journeys = Journey.all
    end

    def show
        @journey = Journey.find(params[:id])
    end

    def enter_wrapup
        wrapup = params.permit(:wrapup)[:wrapup]
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
        @journey = Journey.find(session[:journey_id])
        redirect_to region_space_path(@journey.region, @journey.spaces.last) if session[:wrapup]!=1
    end

    def wrapup_cast
        journey = Journey.find(session[:journey_id])
        @items = journey.items
        # redirect_to region_space_path(@journey.region, @journey.spaces.last) if session[:wrapup]!=2
    end

    def wrapup_casting
        
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