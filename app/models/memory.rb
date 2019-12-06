class Memory < ActiveRecord::Base
  belongs_to :item, optional: true
  belongs_to :space
  belongs_to :journey

  def traveler_name
    if self.journey.present? && self.journey.traveler.present?
      self.journey.traveler.name
    else
      "lost traveler"
    end
  end
end