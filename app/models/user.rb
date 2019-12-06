class User < ActiveRecord::Base
    has_secure_password

    has_many :travelers
    has_many :journeys, through: :travelers
    has_many :items, through: :journeys

    scope :flagged, -> {where(flag:true)}

    validates :username, presence: true, uniqueness: true
    
    def name
        username
    end
end