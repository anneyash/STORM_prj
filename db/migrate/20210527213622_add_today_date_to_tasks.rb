class AddTodayDateToTasks < ActiveRecord::Migration[6.1]
  def change
    change_table :tasks do |t|
      t.datetime :today_at
    end
  end
end
