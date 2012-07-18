class ProjectsController < ApplicationController
  protect_from_forgery

  def index
    @projects = Project.find_by(params[:filters])
  end
end

