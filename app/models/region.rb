class Region < ActiveRecord::Base
    # A region is of many spaces
    # Many journeys can go through each region
    has_many :spaces
    has_many :journeys

    def memory_message
        case self.name
        when "Lab"
        when "Underground City"
        when "Beach"
        when "Underwater"
            "You feel a presence was here."
        when "Cave"
        when "Forest"
            "You see footsteps in the undergrowth."
        when "Ruins"
        when "Plain"
        when "Marsh"
        when "Desert"
        when "Taiga"
        when "Tundra"
        when "Mountain"
        end
    end
end