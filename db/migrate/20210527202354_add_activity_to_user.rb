class AddActivityToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.datetime :activity
    end
  end
end
