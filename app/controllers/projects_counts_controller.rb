class ProjectsCountsController < ApplicationController
  protect_from_forgery

  def index
    @data = Project.count
  end
end

