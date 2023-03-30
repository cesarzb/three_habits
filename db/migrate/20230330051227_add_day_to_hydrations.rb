class AddDayToHydrations < ActiveRecord::Migration[7.0]
  def change
    add_reference :hydrations, :day, null: false, foreign_key: true
  end
end
