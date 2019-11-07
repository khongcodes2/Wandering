class ItemJourney < ActiveRecord::Base
    # join table for Items and Journeys
    belongs_to :item
    belongs_to :journey
end