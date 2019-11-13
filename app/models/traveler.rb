class Traveler < ActiveRecord::Base
  belongs_to :user, optional: true
  has_many :journeys
  has_many :items, through: :journeys
  # has_many :memories, through: :journeys

  scope :no_user, -> {where(user:nil)}
  
  validates :name, :descript, presence: true

  def username
    user.present? ? user.username : "none"
  end

  def current_journey
    journeys.last
  end

  def pickup(item)
    item.space.items.delete(item) if item.space.present?
    current_journey.items.push(item)
  end

  def drop_item(item)
    current_journey.items.delete(item)
    current_journey.current_space.items.push(item)
  end
  
  def drop_all
    current_journey.items.each do |i|
      drop_item(i)
    end
  end

end