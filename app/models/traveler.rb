class Traveler < ActiveRecord::Base
  belongs_to :user, optional: true
  has_many :journeys
  has_many :items, through: :journeys
  # has_many :memories, through: :journeys

  scope :no_user, -> {where(user:nil)}
  
  validates :name, presence: true
  validates :descript, presence: true

  def username
    user.present? ? user.username : "none"
  end

  def current_journey
    journeys.last
  end

  def pickup(item)
    current_journey.push(item)
  end

  def drop(item)
    current_journey.current_space.push(item)
  end
  
  def drop_all
    current_journey.items.each do |i|
      current_journey.current_space.push(i)
    end
  end

end