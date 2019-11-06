class CreateItemJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :item_journeys do |t|
      t.integer :item_id
      t.integer :journey_id
    end
  end
end
