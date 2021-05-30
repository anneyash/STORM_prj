class Task < ApplicationRecord
  belongs_to :project
  has_many :points, dependent: :destroy
  enum task_state: {
      todo: 0,
      today: 1,
      in_process: 2,
      done: 3
  }


end
