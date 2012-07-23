class ProjectsController < ApplicationController

  def index
    unless @projects = Project.find_by(params[:filters])
      Project.fetch_and_publish(params[:filters], cookies.signed[:token])
    end
  end

end