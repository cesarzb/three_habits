class RemoveDatetimeFromSleeps < ActiveRecord::Migration[7.0]
  def change
    remove_column :sleeps, :datetime
  end
end
