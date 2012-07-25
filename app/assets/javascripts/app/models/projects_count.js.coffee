class ProjectsCount extends Spine.Model
  @configure 'ProjectsCount', 'count', 'index'
  @extend Spine.Model.Ajax

  @url = "/projects_counts"

window.ProjectsCount = ProjectsCount