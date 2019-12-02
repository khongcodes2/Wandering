class DropSpaceJourneys < ActiveRecord::Migration[6.0]
  def change
    drop_table :space_journeys
  end
end
