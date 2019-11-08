# reset database:
# rails db:drop
# rails db:create
# rails db:migrate

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

# 13 regions listed
# 40 of each ["",""] in space
# 60 of each ["",""] in items

DATA = {
  :regions => {
    "Lab" => {
      :space_nouns_descript => [
        ["lab.A","1"],
        ["lab.B","2"],
        ["lab.C","3"],
        ["lab.D","4"]
      ],
      :space_adj_descript => [
        ["lab.a","5"],
        ["lab.b","6"],
        ["lab.c","7"],
        ["lab.d","8"]
      ]
    },
    "Underground City" => {
      :space_nouns_descript => [
        ["ug.A","1"],
        ["ug.B","2"],
        ["ug.C","3"],
        ["ug.D","4"]
      ],
      :space_adj_descript => [
        ["ug.a","5"],
        ["ug.b","6"],
        ["ug.c","7"],
        ["ug.d","8"]
      ]
    },
    "Beach" => {
      :space_nouns_descript => [
        ["beach.A","1"],
        ["beach.B","2"],
        ["beach.C","3"],
        ["beach.D","4"]
      ],
      :space_adj_descript => [
        ["beach.a","5"],
        ["beach.b","6"],
        ["beach.c","7"],
        ["beach.d","8"]
      ]
    },
    "Underwater" => {
      :space_nouns_descript => [
        ["underw.A","1"],
        ["underw.B","2"],
        ["underw.C","3"],
        ["underw.D","4"]
      ],
      :space_adj_descript => [
        ["underw.a","5"],
        ["underw.b","6"],
        ["underw.c","7"],
        ["underw.d","8"]
      ]
    },
    "Cave" => {
      :space_nouns_descript => [
        ["cave.A","1"],
        ["cave.B","2"],
        ["cave.C","3"],
        ["cave.D","4"]
      ],
      :space_adj_descript => [
        ["cave.a","5"],
        ["cave.b","6"],
        ["cave.c","7"],
        ["cave.d","8"]
      ]
    },
    "Forest" => {
      :space_nouns_descript => [
        ["forest.A","1"],
        ["forest.B","2"],
        ["forest.C","3"],
        ["forest.D","4"]
      ],
      :space_adj_descript => [
        ["forest.a","5"],
        ["forest.b","6"],
        ["forest.c","7"],
        ["forest.d","8"]
      ]
    },
    "Ruins" => {
      :space_nouns_descript => [
        ["ruins.A","1"],
        ["ruins.B","2"],
        ["ruins.C","3"],
        ["ruins.D","4"]
      ],
      :space_adj_descript => [
        ["ruins.a","5"],
        ["ruins.b","6"],
        ["ruins.c","7"],
        ["ruins.d","8"]
      ]
    },
    "Plain" => {
      :space_nouns_descript => [
        ["plain.A","1"],
        ["plain.B","2"],
        ["plain.C","3"],
        ["plain.D","4"]
      ],
      :space_adj_descript => [
        ["plain.a","5"],
        ["plain.b","6"],
        ["plain.c","7"],
        ["plain.d","8"]
      ]
    },
    "Marsh" => {
      :space_nouns_descript => [
        ["marsh.A","1"],
        ["marsh.B","2"],
        ["marsh.C","3"],
        ["marsh.D","4"]
      ],
      :space_adj_descript => [
        ["marsh.a","5"],
        ["marsh.b","6"],
        ["marsh.c","7"],
        ["marsh.d","8"]
      ]
    },
    "Desert" => {
      :space_nouns_descript => [
        ["desert.A","1"],
        ["desert.B","2"],
        ["desert.C","3"],
        ["desert.D","4"]
      ],
      :space_adj_descript => [
        ["desert.a","5"],
        ["desert.b","6"],
        ["desert.c","7"],
        ["desert.d","8"]
      ]
    },
    "Taiga" => {
      :space_nouns_descript => [
        ["taiga.A","1"],
        ["taiga.B","2"],
        ["taiga.C","3"],
        ["taiga.D","4"]
      ],
      :space_adj_descript => [
        ["taiga.a","5"],
        ["taiga.b","6"],
        ["taiga.c","7"],
        ["taiga.d","8"]
      ]
    },
    "Tundra" => {
      :space_nouns_descript => [
        ["tundra.A","1"],
        ["tundra.B","2"],
        ["tundra.C","3"],
        ["tundra.D","4"]
      ],
      :space_adj_descript => [
        ["tundra.a","5"],
        ["tundra.b","6"],
        ["tundra.c","7"],
        ["tundra.d","8"]
      ]
    },
    "Mountain" => {
      :space_nouns_descript => [
        ["mountain.A","1"],
        ["mountain.B","2"],
        ["mountain.C","3"],
        ["mountain.D","4"]
      ],
      :space_adj_descript => [
        ["mountain.a","5"],
        ["mountain.b","6"],
        ["mountain.c","7"],
        ["mountain.d","8"]
      ]
    }
  },

  :item_nouns_descript => [
    ["sword","1"],
    ["staff","2"],
    ["bow","3"],
    ["bell","4"],
    ["coin","5"],
    ["rod","6"],
    ["disc","7"],

  ],

  :item_adj_descript => [
    ["lost","8"],
    ["i.B","9"],
    ["i.C","10"],
    ["i.D","11"],
    ["i.E","12"],
    ["i.F","13"],
    ["i.G","14"],

  ]
}

def main
  make_regions
  make_spaces
  make_items
end

def make_regions
  DATA[:regions].each do |region_name_string, attr_hash|
    region = Region.create(name:region_name_string)
  end
end

def generate_attributes(part1, part2)
  get={}
  d20 = rand(1..20)
  conjunction = d20.even? ? ", and " : ", but "

  get[:noun] = part1[0]
  get[:adjective] = part2[0]
  get[:descript] = d20<=10 ? part1[1]+conjunction+part2[1] : part2[1]+conjunction+part1[1]
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
  100.times do
    part1 = DATA[:item_nouns_descript].sample
    part2 = DATA[:item_adj_descript].sample
    
    item = Item.new(generate_attributes(part1,part2))
    item.save
  end
end

main
