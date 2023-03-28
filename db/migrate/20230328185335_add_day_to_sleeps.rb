class AddDayToSleeps < ActiveRecord::Migration[7.0]
  def change
    add_reference :sleeps, :day, null: false, foreign_key: true
  end
end
