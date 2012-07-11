class ProjectsController < ApplicationController
  protect_from_forgery

  def index
    @projects = Project.test_data
  end
end
