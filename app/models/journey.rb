class Journey < ActiveRecord::Base
    belongs_to :user, optional: true
    belongs_to :traveler
    belongs_to :region, optional: true
    has_many :spaces, through: :region
    has_many :item_journeys
    has_many :items, through: :item_journeys
    # has_many :memories

    validates :name, presence: true
end