class Project < ApplicationRecord

has_many :tasks, class_name: 'Task', dependent: :destroy
belongs_to :user





end
