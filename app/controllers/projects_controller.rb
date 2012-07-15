class ProjectsController < ApplicationController
  protect_from_forgery

  def index
    @data = Project.test_data
    @projects = @data["proposals"]
  end
end

