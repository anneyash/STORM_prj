class AddTaskIdToPoints < ActiveRecord::Migration[6.1]
  def change
    change_table :points do |t|
      t.references :task, null: false, foreign_key: true
    end
  end
end
