class Space < ActiveRecord::Base
    belongs_to :region
    has_many :space_journeys
    has_many :journeys, through: :space_journeys
    has_many :users, through: :journeys
    has_many :items

    has_many :memories

    validates :noun, :adjective, :descript, presence: true


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