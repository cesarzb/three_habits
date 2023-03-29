class CreateHydrations < ActiveRecord::Migration[7.0]
  def change
    create_table :hydrations do |t|
      t.integer :cups

      t.timestamps
    end
  end
end
