class CreateJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :journeys do |t|
      t.string :name
      t.boolean :completed, default:false
      t.integer :user_id
      t.integer :traveler_id
      t.integer :region_id
    end
  end
end
