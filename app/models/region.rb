class Region < ActiveRecord::Base
    # A region is of many spaces
    # Many journeys can go through each region
    has_many :spaces
    has_many :journeys

    def traveled_space_memory_text(traveler)
        case self.name
        when "Lab"
        when "Underground City"
        when "Beach"
        when "Underwater"
            text = "A presence lingers, a scent in the water: "
        when "Cave"
        when "Forest"
            text = "You see footsteps in the undergrowth: "
        when "Ruins"
        when "Plain"
        when "Marsh"
        when "Desert"
        when "Taiga"
        when "Tundra"
        when "Mountain"
        end
        text + "#{traveler} passed through here."
    end
end