class ProjectsController < ApplicationController

  def index
    @projects = Project.find_by(params[:filters], cookies.signed[:token])
  end
end