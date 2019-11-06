class JourneysController < ApplicationController
    def new
        @journey = Journey.new
        #initialize itemjourney
    end

    def create
        raise params.inspect
    end

    def index
    end

    def show
    end

    def user_index
    end

    private

    def journey_params
        params.require(:journey).permit()
    end

end