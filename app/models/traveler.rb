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

  def pickup_item(item)
  end

  def drop_item(item)
  end

end