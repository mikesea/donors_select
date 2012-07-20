class ProjectsController < ApplicationController

  def index
    @projects = Project.find_by params[:filters]
    unless @projects
      Project.fetch_and_publish params[:filters], cookies.signed[:token]
    end
  end

end