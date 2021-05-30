class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :deadline
      t.string :task_state, null: false
      t.timestamps
    end
  end
end
