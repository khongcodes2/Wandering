class AddFlagToAllTables < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :flag, :boolean, default: false
    add_column :journeys, :flag, :boolean, default: false
    add_column :regions, :flag, :boolean, default: false
    add_column :spaces, :flag, :boolean, default: false
    add_column :travelers, :flag, :boolean, default: false
    add_column :users, :flag, :boolean, default: false
  end
end
