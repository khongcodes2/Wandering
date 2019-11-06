class Journey < ActiveRecord::Base
    # no traveler has more than one journey
    # so each journey is identifiable essentially as TRAVELER_NAME's journey
    # attr_accessor :traveler_name

    belongs_to :user
    
    # each journey is through the spaces of a region
    # along each journey, items are picked up
    belongs_to :region
    has_many :spaces, through: :region
    has_many :item_journeys
    has_many :items, through: :item_journeys
end