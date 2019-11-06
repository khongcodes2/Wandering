class User < ActiveRecord::Base
    has_secure_password
    # These will serve as traveler logs
    has_many :journeys
    has_many :spaces, through: :journeys
    has_many :names, through: :journeys
    has_many :items, through: :journeys

    validates :username, presence: true, uniqueness: true
end