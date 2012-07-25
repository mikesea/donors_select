class ProjectsController < ApplicationController

  def index
    unless @projects = Project.find_by(params[:filters])
      Project.fetch_and_publish(params[:filters], session_token)
    end
  end

end
