class Space < ActiveRecord::Base
    belongs_to :region, optional:true
    has_many :journeys, through: :region
    has_many :users, through: :journeys
    
    # Items can be left behind on spaces
    has_many :items
end