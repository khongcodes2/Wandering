class Region < ActiveRecord::Base
    # A region is of many spaces
    # Many journeys can go through each region
    has_many :spaces
    has_many :journeys
end