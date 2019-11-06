class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string :noun
      t.string :adjective
      t.string :descript
      t.integer :region_id
    end
  end
end
