  # journey.start
  [v] pick a random space in journey.region and assign to journey.spaces

  [v] add journey.clock to journey and session
          (journey.clock = journey.spaces.count)
          dont define method as journey.spaces.count - we dont want to run it every time
          this should load a traveler info sidebar

  # travel loop
  load show journey.spaces.last, load a template/partial to extend functionality-
          - allow navigation (traveler.go)
          - allow for item pickup/drop (traveler.pickup)
      on traveler.go, run journey.tick
              use journey.clock to determine probability of journey.end (set journey.clock to 10)
              # reverse order of these 2 below
              if journey.tick == true
                  space selected for traveler.go added to journey.spaces
                  (journey.clock += 1)
                  show that one (enter beginning of loop)
              elsif journey.tick == false || journey.clock==9
                  inform player their journey is ending
                  journey.clock set to 9
              elsif journey.clock == 10
              if on any space and session[:wrapup] true, redirect
                  journey.end
              end
      
  # journey.end    
  tell player their journey has ended
      [v] let player choose to record:
          [v] last thing traveler saw in the distance (new space)
          [v] last thing traveler saw before their feet (new item)
           -  make it so if session[:wrapup] true, redirect to wrapup_cast
      - pick an item to cast into the ether
      - travelers remaining items are dropped at current space
      - session.delete journey.clock
      - take user to home page