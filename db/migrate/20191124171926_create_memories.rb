class CreateMemories < ActiveRecord::Migration[6.0]
  def change
    create_table :memories do |t|
      t.string :type
      t.string :text
      t.integer :item_id
      t.integer :space_id
      t.integer :journey_id
    end
  end
end
