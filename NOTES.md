# Rough game implementation notes

## journey.start
[v] pick a random space in journey.region and assign to journey.spaces

[v] add journey.clock to journey and session
          (journey.clock = journey.spaces.count)
          dont define method as journey.spaces.count - we dont want to run it every time
          this should load a traveler info sidebar

[v] if already on journey
    continue journey?

# travel loop
journey.start

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
      
## journey.end    
[ ] 1/journeys#wrapup/
    [ ] if session[:wrapup].exists?
        [ ] session[:wrapup] == 2 redirect to /GET wrapup_cast/
    [v] session[:wrapup] == 1

[v] 1/GET wrapup/ tell player journey ended & let player choose to record:
    [v] last thing traveler saw in the distance (new space)
    [v] last thing traveler saw before their feet (new item)


[v] 2/resource#new/
    [v] new: if session[:wrapup]!=1 redirect

[v] 2/GET new_resource/ let player submit new resource

[v] 2/controller#create/ let player create
    [v] new: if session[:wrapup]!=1 disallow
    [v] if item, add to journey's items
    [v] if space, add to journey's spaces
    [v] make it so if session[:wrapup] 1, post redirect to wrapup_cast
    [v] disallow if session wrapup not 1
    [v] session[:wrapup_resource] = link_to new resource
    [^] session[:wrapup]=2


[v] 3/controller#wrapup_cast/ pre-wrapup_cast
    [v] if session[:wrapup]!=1 redirect

[ ] 3/GET wrapup_cast_/
    [^] disallow if session[:wrapup] !=2
    [ ] pick an item to cast into the ether (form, radio buttons)

[ ] 3/controller#post_wrapup_cast/
    [ ] disallow if session[:wrapup] !=2
    [ ] item chosen gets space re-assigned to traveler.space.last
    [ ] travelers remaining items are dropped at current space
    [ ] if session[:wrapup_new_space].exists?, to new space
    [ ] session[:wrapup] = 3
    [ ] redirect to journey_end page


[ ] 4/controller#journey_end/
    [ ] disallow if session[:wrapup] !=3
    [ ] Assign attributes for page
        @traveler
        @items
        @space
        @journey_name
    [ ] session.delete  :journey_id
                        :wrapup
                        :wrapup_new_space
                        :wrapup_resource
    [ ] redirect to root after 15 seconds

[ ] 4/GET journey_end/
    [ ] each item left behind, 1 message: "traveler left X left behind at Y"
    [ ] "Journey ends. Redirecting.."
    [ ] also display root link

    uncomment out session[:wrapup] change in items#create spaces#create