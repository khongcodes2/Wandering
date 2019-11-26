module MemoriesHelper
  
  def item_memory_text(memory)
    traveler = memory.traveler_name
    space = memory.space.name

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
    item = memory.item.name if memory.item.present?

    case memory.mem_type
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

  def journey_memory(memory)
    traveler = memory.traveler_name
    region = memory.journey.region.name
    space = memory.space.name if memory.space.present?
    item = memory.item.name if memory.item.present?

    case memory.mem_type
    when "begin"
      "#{traveler} began the journey in #{region} at the #{space}."
    when "traveler_leave"
      "#{traveler} traveled through the #{space}."
    when "item_pickup"
      "#{traveler} picked up #{item} at the #{space}."
    when "item_drop"
      "#{traveler} dropped #{item} at the #{space}."
    when "end"
      "#{traveler} went back to the Ether, with #{item}."
    end
  end

  def create_traveler_leave_memory
    # if you've moved to this space from a different space
    if (params[:region_id].present? && session[:was_just_on] != params[:id]) || (session[:wrapup].to_i==1)
      memory = Memory.new(mem_type:'traveler_leave')
      memory.space = space_was_just_on
      memory.journey = current_journey
      memory.save

    end
  end

end