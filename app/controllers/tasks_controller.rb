class TasksController < ApplicationController
  def index
  end

  def create
    @task = current_user.projects.find(params[:project_id]).tasks.create(task_params)
  end

  def destroy
    @task = current_user.tasks.find(params[:id]).destroy
  end

  def today

    @today_count = Task.today.count
    @today_done = Task.done.where('today_at > ? AND today_at < ?', Date.today - 1.day, Date.today + 1.day).count

  end

  def makealltoday
    @type = params[:type]
    params[:ids].each do |id|
      @task = current_user.tasks.find(id)
      @task.today!
      @task.update_attribute(:today_at, Date.today)
      @task.points.destroy_all
    end
  end

  def makealltodo
    @type = params[:type]
    params[:ids].each do |id|
      @task = current_user.tasks.find(id)
      if @task.today?
        @task.update_attribute(:today_at, Date.today)
      end
      @task.todo!
      @task.points.destroy_all
    end
  end

  def make_todo
    @task = current_user.tasks.find(params[:id])
    if @task.today?
      @task.update_attribute(:today_at, Date.today)
    end
    @task.todo!
    @task.points.destroy_all

    @today_count = Task.today.count
    @today_done = Task.done.where('today_at > ? AND today_at < ?', Date.today - 1.day, Date.today + 1.day).count
  end

  def make_today
    @task = current_user.tasks.find(params[:id])
    @task.today!
    @task.update_attribute(:today_at, Date.today)
    @task.points.destroy_all
  end

  def make_in_process
    @task = current_user.tasks.find(params[:id])
    @task.in_process!
    @task.points.destroy_all
  end

  def make_done
    @task = current_user.tasks.find(params[:id])
    @task.done!
    @task.update_attribute(:today_at, Date.today)

    @today_count = Task.today.count
    @today_done = Task.done.where('today_at > ? AND today_at < ?', Date.today - 1.day, Date.today + 1.day).count

    if current_user.tasks.done.count == 1
      @task.points.create(quantity: 1, user: current_user)
      @text = "Поздравляем! Ты закрыл свою первую задачу! Лови бонусные баллы"
      @points = 1;
    end
    if current_user.tasks.done.count == 25
      @task.points.create(quantity: 10, user: current_user)
      @text = "Поздравляем! Ты закрыл 25 новых задач! Лови бонусные баллы"
      @points = 10;
    end
    if current_user.tasks.done.count == 50
      @task.points.create(quantity: 20, user: current_user)
      @text = "Поздравляем! Ты закрыл 50 новых задач! Лови бонусные баллы"
      @points = 20;
    end

    if current_user.tasks.done.count == 75
      @task.points.create(quantity: 30, user: current_user)
      @text = "Поздравляем! Ты закрыл 75 новых задач! Лови бонусные баллы"
      @points = 30;
    end
    if current_user.tasks.done.count == 100
      @task.points.create(quantity: 40, user: current_user)
      @text = "Поздравляем! Ты закрыл 100 новых задач! Лови бонусные баллы"
      @points = 40;
    end
  end

  def notifications
    @three_day_tasks = current_user.tasks.where('deadline > ? AND deadline < ?', Date.today + 2.days, Date.today + 4.days)
    @one_day_tasks = current_user.tasks.where('deadline > ? AND deadline < ?', Date.today, Date.today + 2.days)
    @week_tasks = current_user.tasks.where('deadline > ? AND deadline < ?', Date.today + 6.days, Date.today + 8.days)

    @week = []
    if current_user.activity < Date.today - 4.days && current_user.tasks.today
      @week = current_user.tasks.today
    end

    @day = current_user.tasks.where('today_at < ? AND today_at > ?', Date.today, Date.today - 2.days)

    if @three_day_tasks.any?
      @three_day_tasks_titles = @three_day_tasks.pluck(:title).join(', ')
    end

    if @one_day_tasks.any?
      @one_day_tasks_titles = @one_day_tasks.pluck(:title).join(', ')
    end

    if @week_tasks.any?
      @week_tasks_titles = @week_tasks.pluck(:title).join(', ')
    end
    render :notifications
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update(task_params)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end



  private
  def task_params
    params.require(:task).permit(:title, :description, :task_state, :deadline)
  end
end
