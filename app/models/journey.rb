class Journey < ActiveRecord::Base
    belongs_to :user, optional: true
    belongs_to :traveler
    belongs_to :region, optional: true
    has_many :spaces, through: :region
    has_many :item_journeys
    has_many :items, through: :item_journeys
    # has_many :memories

    #just to allow checkboxes to be used in new_journey form
    attr_accessor :random_region_box, :random_traveler_box, :new_traveler_box

    def new_traveler(hash)
        self.traveler = Traveler.new(name:hash[:name],descript:hash[:descript])
    end

end