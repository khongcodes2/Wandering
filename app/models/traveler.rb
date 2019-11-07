class Traveler < ActiveRecord::Base
  belongs_to :user, optional: true
  has_many :journeys
  has_many :items, through: :journeys
  # has_many :memories, through: :journeys

  def username
    user.present? ? user.username : "none"
  end

end