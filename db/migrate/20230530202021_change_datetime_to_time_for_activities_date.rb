class ChangeDatetimeToTimeForActivitiesDate < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :date, :time
  end
end
