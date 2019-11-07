class JourneysController < ApplicationController
    include SessionsHelper

    def new
        @journey = Journey.new
        #initialize itemjourney?
    end

    def create
        @journey = Journey.new(traveler_id:journey_params[:traveler_id])
        @journey.user = current_user
        if @journey.save
            redirect_to journey_path(@journey)
        else
            render :new
        end

        # if not logged in
        # journey.new

        # j.region =
        # review bi-directional many-many forms
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
        params.require(:journey).permit(:traveler_id, :region_id, :items)
    end

end