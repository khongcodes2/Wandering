class Journey < ActiveRecord::Base
    belongs_to :user, optional: true
    belongs_to :traveler
    belongs_to :region
    has_many :space_journeys
    # no longer has_many through regions - all of the region's spaces became the journey's
    has_many :spaces, through: :space_journeys
    has_many :item_journeys
    has_many :items, through: :item_journeys
    # has_many :memories

    #just to allow checkboxes to be used in new_journey form
    attr_accessor :random_region_box, :random_traveler_box, :new_traveler_box, :clock

    def new_traveler(hash)
        self.traveler = Traveler.new(name:hash[:name],descript:hash[:descript])
    end
       
    def start
        clock = 0
        spaces.push(region.spaces.sample)
    end

end