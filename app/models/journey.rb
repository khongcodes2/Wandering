class Journey < ActiveRecord::Base
    belongs_to :user, optional: true
    belongs_to :traveler
    belongs_to :region
    has_many :memories
    has_many :space_journeys
    has_many :spaces, through: :space_journeys
    has_many :item_journeys
    has_many :items, through: :item_journeys

    scope :last_10_completed,   -> {where(completed:true).last(10).reverse}

    scope :flagged,             -> {where(flag:true)}

    #just to allow checkboxes to be used in new_journey form
    attr_accessor :random_region_box, :random_traveler_box, :new_traveler_box

    def new_traveler(hash)
        self.traveler = Traveler.new(name:hash[:name],descript:hash[:descript])
    end

    def traveler_option
        # empty method allowing for passing of traveler_option key in options hash into New Journey form
    end
       
    def start
        self.clock = 0
        save
    end

    def tick_clock
        case self.clock
        when 0..2
            self.clock += 1
        when 3..7
            case self.clock
            when 3
                continue_chance = 7
            when 4
                continue_chance = 5
            when 5
                continue_chance = 3
            when 6
                continue_chance = 2
            when 7
                continue_chance = 1
            end
            
            if rand(1..10)>continue_chance
                # begin signaling end to user
                self.clock = 9
            else
                self.clock += 1
            end
        when 8..9
            self.clock += 1
        end
        self.save
    end

    def current_space=(arg)
        spaces << arg
    end

    def current_space
        spaces.last
    end

    def created_by_user
        self.user
    end

    def created_by_traveler
        self.traveler
    end

end