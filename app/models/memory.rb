class Memory < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :space
  belongs_to :journey

  def traveler_name
    self.journey.traveler.name
  end
end