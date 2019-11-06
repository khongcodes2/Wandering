class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :noun
      t.string :adjective
      t.string :descript
      t.string :space_id
    end
  end
end
