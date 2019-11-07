class Space < ActiveRecord::Base
    belongs_to :region, optional:true
    has_many :journeys, through: :region
    has_many :users, through: :journeys
    has_many :items
    # has_many :memories

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