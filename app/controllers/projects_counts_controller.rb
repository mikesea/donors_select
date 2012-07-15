class ProjectsCountsController < ApplicationController
  protect_from_forgery

  def index
    @data = Project.test_data
  end
end

