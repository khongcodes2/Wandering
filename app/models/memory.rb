class Memory < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :space, optional: true
  belongs_to :journey, optional: true



  def text(read_location)
    case read_location
    when "item"
      "Picked up by #{self.journey.traveler_name} at #{self.space.name}."
    when "space"
      self.space.region.message
    when "journey" || "traveler"
      if self.type == "item"
        "#{self.journey.traveler_name} picked up #{self.item.name} at #{self.space.name}."
      else
        "#{self.journey.traveler_name} traveled through #{self.space.name}."
      end
    end
  end
end