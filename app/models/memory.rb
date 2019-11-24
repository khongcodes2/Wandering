class Memory < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :space
  belongs_to :journey



  def text(read_location)
    case read_location
    when "item"
      "Picked up by #{self.journey.traveler_name} at #{self.space.name}."
    when "space"
      self.space.region.memory_message
    else
      if self.mem_type == "item"
        "#{self.journey.traveler_name} picked up #{self.item.name} at #{self.space.name}."
      else
        "#{self.journey.traveler_name} traveled through #{self.space.name}."
      end
    end
  end
end