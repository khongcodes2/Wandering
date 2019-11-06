class CreateJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :journeys do |t|
      t.string :traveler_name
      t.integer :user_id
      t.integer :region_id
    end
  end
end
