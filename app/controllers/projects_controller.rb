class ProjectsController < ApplicationController
  include SessionsHelper
  def index

  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def create
    @project = current_user.projects.new(project_params)

     if @project.save
       respond_to do |f|
         f.js
       end
     end
  end

  def destroy

    @project = current_user.projects.find(params[:id])
    @project.destroy

  end


  def update
    @project = current_user.projects.find(params[:id])
    @project.update(project_params)
  end


  private
  def project_params
    params.require(:project).permit(:title)
  end
end
