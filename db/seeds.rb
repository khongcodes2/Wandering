# TO RESET DATABASE:
# rails db:drop
# rails db:create
# rails db:migrate
# rails db:seed

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# GOAL: 13 regions listed
#  - Lab
#  - Underground City
#  - Beach
#  - Underwater
#  - Cave
#  - Forest
#  - Ruins
#  - Plain
#  - Marsh
#  - Desert
#  - Taiga
#  - Tundra
#  - Mountain

# 40 nouns and adjective descriptions within each region
# 60 noun and adjective descriptions within items

DATA = {
  :regions => {
    # "Lab" => {
    #   :space_nouns_descript => [
    #     ["lab.A","1"],
    #     ["lab.B","2"],
    #     ["lab.C","3"],
    #     ["lab.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["lab.a","5"],
    #     ["lab.b","6"],
    #     ["lab.c","7"],
    #     ["lab.d","8"]
    #   ]
    # },
    # "Underground City" => {
    #   :space_nouns_descript => [
    #     ["ug.A","1"],
    #     ["ug.B","2"],
    #     ["ug.C","3"],
    #     ["ug.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["ug.a","5"],
    #     ["ug.b","6"],
    #     ["ug.c","7"],
    #     ["ug.d","8"]
    #   ]
    # },
    # "Beach" => {
    #   :space_nouns_descript => [
    #     ["beach.A","1"],
    #     ["beach.B","2"],
    #     ["beach.C","3"],
    #     ["beach.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["beach.a","5"],
    #     ["beach.b","6"],
    #     ["beach.c","7"],
    #     ["beach.d","8"]
    #   ]
    # },
    "Underwater" => {
      :space_nouns_descript => [
        ["reef","the colorful splashes of life fill you with a feeling of lightness"],
        ["reef","fish swim playfully around you"],
        ["grotto","it's tight, but you feel safe here"],
        ["grotto","you settle next to a small nest made by a family of cuttlefish. They eye you apprehensively"],
        ["kelp forest","the kelp mottles the light around you with their sway"],
        ["kelp forest","some seahorses duck out of sight as you approach"],
        ["chasm","the abyss stares back"],
        ["chasm","at this distance, you think you can make out some eels poking out from the sides of the ravine"],
        ["trench","unimaginably deep and dark, the abyss stares back"],
        ["cave","your hand traces scratches in the wall that feel like some kind of writing"],
        #10
        ["cave","you see the remains of something"],
        ["open water","a shark lazily drifts by you"],
        ["open water","out of the corner of your eye something darts away"],
        ["open water","you're surrounded by a world of blue"],
        ["riverbank","little nests of piled stone dot the riverbed"],
        ["huge open pipe","it looks like you could swim through if you wanted to"],
        ["huge open pipe","nothing comes out - this one ran dry centuries ago"],
        ["seabed","an octopus carrying an old bronze helmet scuttles away"],
        ["seabed","you touchdown in a fairy ring of starfish"],
        ["seabed","garden eels pop back into the floor as you reach it"],
        #20
        ["shipwreck","it's been abandoned for a long time"],
      ],
      :space_adj_descript => [
        ["clear","light pours in from above and dances around you"],
        ["clear","the dawning sun begins to color the very top of the water a soft rose"],
        ["clear","the water matches the grey sky"],
        ["crystal clear","the horizon seems to disappear for a moment and you fall into the sky. It's there when you check again though"],
        ["cloudy","sediment stirs as life leaves little wakes around you"],
        ["crowded","you're enveloped in a whirling school of small silver fish"],
        ["crowded","small crabs with three arms take up all the floor space - you can hardly move without feeling a hard shell or a retaliatory pinch"],
        ["murky","it's hard to see - the water teems, and you can hardly see a few feet in front of you"],
        ["deep","it's dark here"],
        ["deep","it's dark here. Something stirs, and you don't know if it was from inside you or somewhere around you"],
        #10
        ["deep and dark","Something brushes your leg"],
        ["silent","it's quiet here"],
      ]
    },
    # "Cave" => {
    #   :space_nouns_descript => [
    #     ["cave.A","1"],
    #     ["cave.B","2"],
    #     ["cave.C","3"],
    #     ["cave.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["cave.a","5"],
    #     ["cave.b","6"],
    #     ["cave.c","7"],
    #     ["cave.d","8"]
    #   ]
    # },
    "Forest" => {
      :space_nouns_descript => [
        ["glade","six trees mark the edges of the glade, all equidistant from the center and sporting differnet bones hanging off them"],
        ["glade","there's a fairy ring here that you give a wide berth"],
        ["hollow","you can just barely fit inside this tree trunk"],
        ["hollow","you think you see something move inside the empty trunk"],
        ["burrow","the roots of a sturdy tree form the ceiling of this little enclave"],
        ["burrow","a curious spider dangles down from the ceiling, inspecting you"],
        ["clearing","the trees give way to a small, grassy space."],
        ["mossy boulder","it sits in the middle of the path in contemplatively"],
        ["pathway","it stretches and dives further into the woods"],
        ["pathway","roots break the earth and spread through the pathway"],
        #10
        ["copse","the trees sway gently"],
        ["copse","each tree has a yellow tag with identifying information on it"],
        ["sapling nursery","they're getting all A's"],
        ["sapling nursery","they're growing handsomely, though slowly"],
        ["fungal nursery","they bloom slowly and pridfeully, overtaking a statue of a figure and the surrounding vegetation"],
        ["thicket","it's verdant"],
        ["grove","young trees are able to grow here"],
        ["orchard","small yellow fruit, dappled in vermillion ripen here"],
        ["stream","the water is cool and refreshing"],
        ["bridge","a very large white marble structure that crosses such a small brook"],
        #20
        ["shelter","you feel safe in the abandoned makeshift shelter of piled branches"],
        ["shelter","there is a hollow-ness left behind in this abandoned place"],
        ["weald","it's verdant"],
        ["cluster of bushes","they are perfectly round"],
        ["cluster of bushes","you briefly wonder what might live inside"],
        ["coppice","you feel the air weave through and around the cut saplings"],
        ["school of saplings","they stand near yet apart, in awkward, gangly adolescence"],
        ["graveyard","it's sprawling"],
        ["graveyard","it's dense; there's hardly any room to walk between the gravestones"],
        ["gates","the spindly metal is falling apart"],
        #30
        ["mycellicum","an immense structure looms, a lexicon to architectural language of fungus"],
        
      ],
      :space_adj_descript => [
        ["shaded","the undergrowth is heavier here"],
        ["shady","you spy a snail inching forward on a tree branch"],
        ["breezy","the wind makes you feel light"],
        ["breezy","you hear faint laughter from somewhere"],
        ["windy","all you can hear are deafening waves of an ocean of leaves crashing against the shore of each other"],
        ["calm","you feel calm here"],
        ["peaceful","you try not to disturb anything here"],
        ["quiet","the only sounds here are your footsteps"],
        ["still","it almost feels like time itself stands still"],
        ["teeming","the wind moves such that the vines and leaves come to life, whipping and thrashing the air"],
        #10
        ["teeming","the air buzzes around you with insects and birds performing the play of their lives"],
        ["lively","the air is abuzz with a thounsand birdsongs"],
        ["fractal","life grows on top of life, crowding itself"],
        ["thick","pollen hangs in the air, dense enough to see"],
        ["thick","spores hang in the air"],
        ["enclosed","this space feels protected"],
        ["enclosed","this space feels isolated"],
        ["enclosed","the air doesn't move much here"],
      ]
    },
    # "Ruins" => {
    #   :space_nouns_descript => [
    #     ["ruins.A","1"],
    #     ["ruins.B","2"],
    #     ["ruins.C","3"],
    #     ["ruins.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["ruins.a","5"],
    #     ["ruins.b","6"],
    #     ["ruins.c","7"],
    #     ["ruins.d","8"]
    #   ]
    # },
    # "Plain" => {
    #   :space_nouns_descript => [
    #     ["plain.A","1"],
    #     ["plain.B","2"],
    #     ["plain.C","3"],
    #     ["plain.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["plain.a","5"],
    #     ["plain.b","6"],
    #     ["plain.c","7"],
    #     ["plain.d","8"]
    #   ]
    # },
    # "Marsh" => {
    #   :space_nouns_descript => [
    #     ["marsh.A","1"],
    #     ["marsh.B","2"],
    #     ["marsh.C","3"],
    #     ["marsh.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["marsh.a","5"],
    #     ["marsh.b","6"],
    #     ["marsh.c","7"],
    #     ["marsh.d","8"]
    #   ]
    # },
    "Desert" => {
      :space_nouns_descript => [
        ["legs of a colossus","the rough-hewn shins of some forgotten stone king stretch to the sky"],
        ["tomb","the entrance to some deep dark chamber, still mostly covered in sand"],
        ["dune","a tsunami of sand caught in time, demanding a laborious climb"],
        ["dune","a mountainous molehill offering an easy downhill slide"],
        ["valley","a roving pathway forms where the base of one ten-story ridge of sand meets another, of concrete"],
        ["waste","the only thing around is sand, and it stretches to the horizon"],
        ["stretch","you follow a lightly marked road"],
        ["sinkhole","you take care to clutch your belongings and pretend the sinkhole isn't there as you edge around it (the way you were taught)"],
        ["sandlion den","you almost don't notice the neat, smooth downward spiral into a frozen whirlpool in the sand - best stay well away from its edges"],
        ["mirage","the sand and wind whip up ghosts. You hear the name your family used to call you - but when you turn around, no one's there"],
        # 10
        ["mirage","the sand and wind whip up persuasive whispers. You hear the whistle of a trolley of Antique times in the distance"],
        ["mirage","the sand and wind whip up fever dreams before your eyes. You walk into a square in your hometown - but it's gone as soon as you blink"],
        ["oasis","ferns and fronds bend around a pool of magenta water - it's not safe to stay for long"],
        ["abandoned skiff","the craft lies carelessly discarded on its side; sail still intact and thrumming the air; sand starting to pile into its open deck hatch"],
        ["weather rod","a decrepit station that used to be used for sending commands to the atmoforming satellites - they follow no orders now"],
        ["bunker","you see a concrete shelter stripped of its sensor array"],
        ["empty shrine","you pause before an empty stone semi-circle of square columns in the ground. Some of them have toppled - whatever gods used to reside here have forgotten this place long ago"],
        ["tower","an immense, cylindrical, stone tower stands before you with no visible means of entry"],
        ["tower vicinity","just before the horizon, a tower has managed to remain upright through ages of the continuously-reconfiguring landscape"],
        ["tower vicinity","a tower, not too distant, stretches into the expanse above"],
        #20
        ["ravine","you walk through a gorge with steep, craggy walls"],
        ["canyon","you follow the wanderings of a long-dead stream through a stone labyrinth"],
      ],
      :space_adj_descript => [
        ["desolate","there's an overwhelming emptiness"],
        ["oppressive","the grit in the air is smothering"],
        ["oppressive","with no cloud cover, you burn under the sun's scrutiny"],
        ["rosy","everything is tinted a vibrant pink by the morning sun filtering through gritclouds"],
        ["dusty","dust falls upward into the sky from the tracks you make in the sand"],
        ["stormcurbed","the skies roil and bubble, and storm threatens to break (though it never does, here)"],
        ["windsheared","it's remarkable that anything here withstands the local winds' ceaseless cut"],
        ["quiet","the winds are calm right now"],
        ["calm","the lavender sky is quiet right now"],
        ["still","the air is almost totally still"],
        #10
        ["quiet","the sky rumbles discontentedly for half a minute before calming"],
        ["hazy","the horizon blurs in the cloud formed by sand drifting upward out of the ground and into the sky"],
      ]
    },
    # "Taiga" => {
    #   :space_nouns_descript => [
    #     ["taiga.A","1"],
    #     ["taiga.B","2"],
    #     ["taiga.C","3"],
    #     ["taiga.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["taiga.a","5"],
    #     ["taiga.b","6"],
    #     ["taiga.c","7"],
    #     ["taiga.d","8"]
    #   ]
    # },
    # "Tundra" => {
    #   :space_nouns_descript => [
    #     ["tundra.A","1"],
    #     ["tundra.B","2"],
    #     ["tundra.C","3"],
    #     ["tundra.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["tundra.a","5"],
    #     ["tundra.b","6"],
    #     ["tundra.c","7"],
    #     ["tundra.d","8"]
    #   ]
    # },
    # "Mountain" => {
    #   :space_nouns_descript => [
    #     ["mountain.A","1"],
    #     ["mountain.B","2"],
    #     ["mountain.C","3"],
    #     ["mountain.D","4"]
    #   ],
    #   :space_adj_descript => [
    #     ["mountain.a","5"],
    #     ["mountain.b","6"],
    #     ["mountain.c","7"],
    #     ["mountain.d","8"]
    #   ]
    # }
  },

  :item_nouns_descript => [
    ["sword","it has a simple golden handle"],
    ["rapier","it has a fancy handguard"],
    ["falchion","it's got some heft"],
    ["practice sword","the edge is dull"],
    ["staff","it's long but practical"],
    ["bow","it's still got its bowstring"],
    ["bell","it still rings true"],
    ["coin","it shows the face of someone long gone"],
    ["rod","it knows the way"],
    ["disc","it fits just barely in the center of your hand"],
    #10
    ["shield","it looks sufficiently protective"],
    ["spoon","handy"],
    ["pack","it holds just enough"],
    ["arrowhead","it digs into your palm when you clench your fist with it inside"],
    ["deck of cards","the card on top is The Tower"],
    ["deck of cards","the card on top is the ace of spades"],
    ["deck of cards","the card on top is The Golden Son"],
    ["icon","a saint holding a head in one hand and a ceremonial knife in another, anointed with a necklace of skulls"],
    ["datapad","it looks like it contains lists of ingredients for recipes (the top one is cornbread)"],
    ["picture frame","it's empty"],
    #20
    ["picture frame","it holds a drawing of a cat"],
    ["gauntlet","it's hot"],
    ["device","it has buttons and an empty compartment in the back"],
    ["ruby ring","it bears a gem of crystal fire, clouded from use"],
    ["sapphire ring","it bears a gem of the deep sea, cracked"],
    ["dice","the pair of ancient implements unveil unwelcome truths"],
    ["weighted die","it's a cheater's tool"],
    ["telephone","it plays a single tone as it waits for input from an absent receiver"],
    ["shellephone","when you speak into it, you hear your voice, echoing back, distorted"],
    ["dagger","it's a small blade"],
    #30
    ["knife","the serration makes it useful for breaking bread precisely"],
    ["sail","it's tattered and bleached"],
    ["flag","centered on it is an unreadable emblem"],
    ["hand crab","it fits right in your hand"],
    ["incrementer","when you click it, the number on its display goes up by one"],
    ["cup","it's a courtly grail"],

  ],

  :item_adj_descript => [
    ["lost","there's someone's name written on the back"],
    ["rusty","it's been overexposed"],
    ["worn","it looks like it would barely get the job done at this point"],
    ["degraded","it looks like it would barely get the job done at this point"],
    ["defaced","maybe someone wanted to ruin the concept of this object"],
    ["infamous","you've heard of it"],
    ["wooden","it has a well-crafted grain and finish"],
    ["old, wooden","it's gnarled"],
    ["wood","it looks like twisting saplings grew into this shape of their own volition"],
    ["old","it has a great big crack down the middle"],
    #10
    ["bronze","it rings slightly in your hands"],
    ["baroque","it's been overzealously decorated with oak leaf motifs"],
    ["neural-engraved","every inch of its surface holds carved script that rolls fluidly into every other inch"],
    ["elaborate","it was made with a painstakingly fine eye for detail"],
    ["over-complicated","it somehow looks like it has more parts than it actually needs"],
    ["scavenged","a battery here, a dish there; it's been slapped together with a bunch of disparate parts that barely hold together"],
    ["scripted","every inch of its surface holds carved script that rolls fluidly into every other inch"],
    ["articulated","it's made with flexible joints"],
    ["well-made","it's been artfully crafted"],
    ["woeful","you feel sad holding it"],
    #20
    ["haunted","you think you hear crying"],
    ["balanced","holding it feels good"],
    ["cursed","you feel dread wash over you in waves when you hold this"],
    ["delicate","it would break easily if you used it carelessly"],
    ["digital","it seems to contain information for an old-world machine"],
    ["dowsing","when you hold it, you feel it pulling you in a direction"],
    ["discarded","it's been crumpled and thrown away"],
    ["ornate","studded with precious stones"],
    ["ritual","the decoration seems to indicate that it was made with a ceremonial purpose in mind"],
    ["nemesis","it seems to mock you"],
    #30
    ["beholder's","you feel something turn to look at you"],
    ["cat's","it's covered in hair"],
    ["dog's","it's well-worn from use"],
    ["snake's","something about its form suggests twisting movement"],


  ]
}

def main
  delete_all
  make_regions if Region.all.empty?
  make_spaces
  make_items
  make_admin
  # test_flags
end

def delete_all
  Item.destroy_all
  Space.destroy_all
  ItemJourney.destroy_all
  SpaceJourney.destroy_all
  # Region.destroy_all
  # Journey.destroy_all
end

def make_regions
  DATA[:regions].each do |region_name_string, attr_hash|
    region = Region.create(name:region_name_string)
  end
end

def generate_attributes(part1, part2)
  get={}
  d20 = rand(1..20)
  # conjunction = d20.even? ? ", and " : ", but "
  conjunction = ", and "

  get[:noun] = part1[0]
  get[:adjective] = part2[0]
  # get[:descript] = d20<=10 ? part1[1].capitalize+conjunction+part2[1]+"." : part2[1].capitalize+conjunction+part1[1]+"."
  get[:descript] = part2[1].capitalize+conjunction+part1[1]+"."
  get
end

def make_spaces
  DATA[:regions].each do |region_name_string,attr_hash|
    region = Region.find_by(name:region_name_string)
    40.times do
      part1 = attr_hash[:space_nouns_descript].sample
      part2 = attr_hash[:space_adj_descript].sample

      region.spaces.build(generate_attributes(part1,part2))
      region.save
    end
  end
end

def make_items
  Region.all.each do |region|
    50.times do
      part1 = DATA[:item_nouns_descript].sample
      part2 = DATA[:item_adj_descript].sample
      
      item = Item.new(generate_attributes(part1,part2))
      item.space = region.spaces.all.sample
      item.save
    end
  end

  #space-less items
  70.times do
    part1 = DATA[:item_nouns_descript].sample
    part2 = DATA[:item_adj_descript].sample
    
    item = Item.new(generate_attributes(part1,part2))
    item.save
  end
end

def make_admin
  admin = User.new(username:'admin', password:'admin', admin:true)
  admin.save
end

def test_flags
  [1,2,3,4,5].each do |e|
    user = User.new(username:"shit#{e}", password:'p', flag:true)
    user.save
    2.times do
      traveler = user.travelers.build(name:"nameshitSHIT#{e}", descript:"shitSHItshitdescript#{e}", flag:true)
      traveler.save
      journey = traveler.journeys.build(name:"shitJourneySHIT#{e}", region_id:Region.order('RANDOM()').last.id, user_id:user.id, flag:true)
      journey.save

      space1 = Space.order('RANDOM()').last
      mem1 = Memory.new(mem_type:'begin', journey_id:journey.id, space_id:space1.id)
      mem1.save

      mem2 = Memory.new(mem_type:'traveler_leave', journey_id:journey.id, space_id:space1.id)
      mem2.save

      space2 = Space.order('RANDOM()').last
      item1 = Item.order('RANDOM()').last
      mem3 = Memory.new(mem_type:'item_pickup', journey_id:journey.id, item_id:item1.id, space_id:space2.id)
      mem3.save
      mem4 = Memory.new(mem_type:'item_drop', journey_id:journey.id, item_id:item1.id, space_id:space2.id)
      mem4.save

      new_item = journey.items.build(noun:"shitnoun#{e}", adjective:"shItadj#{e}", descript:"shitshiTtyshitdescript#{e}", flag:true)
      new_item.save
      mem5 = Memory.new(mem_type:"item_discovery", item_id:new_item.id, journey_id:journey.id, space_id:space2.id)
      mem5.save

      new_space = journey.spaces.build(noun:"SHiTnoun#{e}", adjective:"shitshitshitshitadj#{e}", descript:"shitshitshitSHITdescript#{e}", region_id:1, flag:true)
      new_space.save
      mem6 = Memory.new(mem_type:"space_discovery", space_id:new_space.id, journey_id:journey.id)
      mem6.save
    end
  end
end

main
