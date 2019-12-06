module MemoriesHelper
  
  def item_memory_text(memory)
    traveler = memory.traveler_name
    space = memory.space.present? ? memory.space.name : "lost space"

    case memory.mem_type

    when "item_discovery"
      "Discovered by #{traveler} at the #{space}."

    when "item_pickup"
      "Picked up by #{traveler}."

    when "item_drop"
      "Dropped by #{traveler} at the #{space}."
    end
  end

  def space_memory_text(memory)
    traveler = memory.traveler_name
    item = memory.item.present? ? memory.item.name : "lost item"

    case memory.mem_type
    
    when "begin"
      if current_journey == memory.journey
        "You entered here from the Ether."
      else
        "The trace of a rift - #{traveler} entered here from the Ether."
      end

    when "space_discovery"
      "Discovered by #{traveler}."

    when "traveler_leave"
      if current_journey == memory.journey
        # If this is a memory of leaving this space and is one of the last 2 spaces traveler left, say, "You return"
        last_2_space_ids = current_journey.memories.where(mem_type:'traveler_leave').last(2).pluck(:space_id)
        space = current_space
        if (space.memories.last == memory) && last_2_space_ids.include?(space.id)
          "You return."
        else
          "You passed through here."
        end
      else
        memory.journey.region.traveled_space_memory_text(traveler)
      end
      
    when "item_discovery"
      "#{traveler} discovered #{item} here."

    when "item_pickup"
      "#{traveler} picked up #{item} here."

    when "item_drop"
      "#{traveler} dropped #{item} here."
    end
  end

  def journey_memory_text(memory)
    traveler = memory.traveler_name
    region = memory.journey.region.name
    space = memory.space.present? ? memory.space.name : "lost space"
    item = memory.item.present? ? memory.item.name : "lost item"

    case memory.mem_type
      
    when "begin"
      "#{traveler} began the journey in #{region} at the #{space}."

    when "traveler_leave"
      "#{traveler} traveled through the #{space}."

    when "item_pickup"
      "#{traveler} picked up #{item} at the #{space}."

    when "item_drop"
      "#{traveler} dropped #{item} at the #{space}."

    when "space_discovery"
      "#{traveler} discovered #{space}."

    when "item_discovery"
      "#{traveler} discovered #{item}."

    when "end"
      if memory.item.present?
        "#{traveler} went back to the Ether from #{space}, with #{item}."
      else
        "#{traveler} went back to the Ether from #{space}."
      end
    end
  end

end