class Item < ActiveRecord::Base
    # Any one item may be a part of multiple travelers' journeys as they are left behind
    has_many :item_journeys
    has_many :journeys, through: :item_journeys
    has_many :travelers, through: :journeys
    has_many :users, through: :travelers
    belongs_to :space, optional: true
    # has_many :memories

    validates :noun, presence: true

    # make noun required
    # make adjective optional

    def name
        if adjective.present? && noun.present?
            adjective+" "+noun
        elsif !adjective.present?
            noun
        else
            adjective
        end
    end
end