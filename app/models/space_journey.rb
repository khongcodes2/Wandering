class SpaceJourney < ActiveRecord::Base
  # join table for Items and Journeys
  belongs_to :space
  belongs_to :journey
end