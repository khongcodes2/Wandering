class Item < ActiveRecord::Base
    has_many :item_journeys
    has_many :journeys, through: :item_journeys
    has_many :travelers, through: :journeys
    has_many :users, through: :travelers
    belongs_to :space, optional: true
    # has_many :memories

    validates :noun, presence: true

    scope :unspaced,            -> {where(space:nil)}
    scope :starting_three,  -> {unspaced.order('RANDOM()').limit(3)}

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