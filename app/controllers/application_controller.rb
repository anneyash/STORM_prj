class ApplicationController < ActionController::Base
  include SessionsHelper

  after_action :user_activity, :check_yesterday_tasks

  def user_activity
    if signed_in_user?
      current_user.activity_update
    end
  end

  def check_yesterday_tasks
    tasks = Task.todo.where( 'today_at < ? AND today_at > ?', Date.today, Date.today - 2.days )
    if tasks.any?
      tasks.each do |task|
        task.today!
      end
    end
  end



end
