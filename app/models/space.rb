class Space < ActiveRecord::Base
    belongs_to :region
    has_many :space_memories
    has_many :journeys, through: :memories
    has_many :users, through: :journeys
    has_many :items

    has_many :memories

    validates :noun, :adjective, :descript, presence: true

    scope :flagged,             -> {where(flag:true)}

    def name
        if adjective.present? && noun.present?
            adjective+" "+noun
        elsif !adjective.present?
            noun
        else
            adjective
        end
    end

    def created_by_user
        self.memories.first.journey.user
    end

    def created_by_traveler
        self.memories.first.journey.traveler
    end
    
end