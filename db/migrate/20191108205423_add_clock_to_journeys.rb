class AddClockToJourneys < ActiveRecord::Migration[6.0]
  def change
    add_column :journeys, :clock, :integer
  end
end
