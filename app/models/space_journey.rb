class SpaceJourney < ActiveRecord::Base
  belongs_to :space
  belongs_to :journey
end