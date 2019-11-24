module MemoriesHelper
  
  def item_memory_text(memory)
    traveler = memory.traveler_name
    space = memory.space.name

    case memory.mem_type
    when "item_discovery"
      "Discovered by #{traveler} at #{space}."
    when "item_pickup"
      "Picked up by #{traveler}."
    when "item_drop"
      "Dropped by #{traveler} at #{space}."
    end
  end

  def space_memory_text(memory)
    traveler = memory.traveler_name
    item = memory.item.name if memory.item.present?

    case memory.mem_type
    when "space_discovery"
      "Discovered by #{traveler}."
    when "traveler_leave"
      memory.journey.region.traveled_space_memory_text(traveler)
    when "item_discovery"
      "#{traveler} discovered #{item} here."
    when "item_pickup"
      "#{traveler} picked up #{item} here."
    when "item_drop"
      "#{traveler} dropped #{item} here."
    end
  end

  def journey_memory(memory)
    traveler = memory.traveler_name
    region = memory.journey.region.name
    space = memory.space.name if memory.space.present?
    item = memory.item.name if memory.item.present?

    case memory.mem_type
    when "begin"
      "#{traveler} began the journey in #{region} at #{space}."
    when "traveler_enter"
      "#{traveler} traveled to #{space}."
    when "item_pickup"
      "#{traveler} picked up #{item} at #{space}."
    when "item_drop"
      "#{traveler} dropped #{item} at #{space}."
    when "end"
      "#{traveler} went back to the Ether, with #{item}."
    end
  end

end