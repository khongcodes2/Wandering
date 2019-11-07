class CreateTravelers < ActiveRecord::Migration[6.0]
  def change
    create_table :travelers do |t|
      t.string :name
      t.string :descript
      t.integer :user_id
    end
  end
end
