class ChangeTypeForTaskState < ActiveRecord::Migration[6.1]
  def change
    change_table :tasks do |t|
     t.change :task_state, :integer
   end
  end
end
