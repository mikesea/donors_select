class ProjectsCountsController < ApplicationController

  def index
    @data = Project.count
  end
end

