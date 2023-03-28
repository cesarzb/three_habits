class CreateSleeps < ActiveRecord::Migration[7.0]
  def change
    create_table :sleeps do |t|
      t.date :datetime
      t.time :length

      t.timestamps
    end
  end
end
