class JourneysController < ApplicationController
    include SessionsHelper

    def new
        @journey = Journey.new
        @available_travelers = current_user ? current_user.travelers : Traveler.no_user
        @regions = Region.all
        @starting_three = Item.starting_three
    end

    def create
        @journey = Journey.new

        @available_travelers = current_user ? current_user.travelers : Traveler.no_user
        if journey_params[:new_traveler_box]=="1"
            @journey.new_traveler(journey_params[:new_traveler])
            if @journey.traveler.save
                byebug
            else
                @regions = Region.all
                @starting_three = Item.starting_three
                render '/journeys/new' and return
                byebug
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
        @journey.items.push(Item.find(journey_params[:items])) unless journey_params[:items].nil?
        
        if @journey.save
            redirect_to journey_path(@journey)
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

    def user_index
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