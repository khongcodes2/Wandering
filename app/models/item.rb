class Item < ActiveRecord::Base
    # Any one item may be a part of multiple travelers' journeys as they are left behind
    has_many :item_journeys
    has_many :journeys, through: :item_journeys
    has_many :users, through: :journeys
    belongs_to :space
end