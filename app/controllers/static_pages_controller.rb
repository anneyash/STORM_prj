class StaticPagesController < ApplicationController
  def index
    redirect_to projects_path
  end
end
