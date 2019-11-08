class CreateSpaceJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :space_journeys do |t|
      t.integer :space_id
      t.integer :journey_id
    end
  end
end
