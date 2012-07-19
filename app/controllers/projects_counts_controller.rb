class ProjectsCountsController < ApplicationController

  def index
    @data = Project.find_by(params[:filters], cookies.signed[:token])
  end
end

