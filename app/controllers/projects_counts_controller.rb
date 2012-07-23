class ProjectsCountsController < ApplicationController

  def index
    @data = Project.find_by(params[:filters])
  end
end

