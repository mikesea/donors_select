class Projector extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".projects-list" : "projects"
    ".projects-count" : "count"

  events:
    "click .project-image" : "showInfo"
    "click .close-button" : "hideRecommendation"

  constructor: ->
    super
    Project.bind 'create', @addMedium
    Project.bind 'refresh', @addAll
    Project.fetch()
    Project.bind "refresh", @checkRecommendation
    ProjectsCount.bind "refresh", @updateCount
    ProjectsCount.bind "create", @updateCount
    ProjectsCount.fetch()

  showInfo: (e) ->
    $('.spotlight-inner').empty()
    project_id = $(e.target).parent().attr('data-id')
    project = Project.find(project_id)
    @displayRecommendation(project)

  addAll: =>
    @projects.empty()
    for project in Project.all()
      @addProject(project)

  checkRecommendation: =>
    if Project.all().length <= 1000
      @displayRecommendation(Project.first())

  addProject: (project) =>
    @projects.append @projectTemplate(project)

  displayRecommendation: (project) ->
    $('.spotlight-inner').empty()
    $('.spotlight-inner').append @recommendationTemplate(project)

  projectTemplate: (project) ->
    @view('projects/project_info')(project:
      project)

  recommendationTemplate: (project) ->
    @view('projects/recommendation')(project:
      project)

  updateCount: =>
    @count.empty()
    @count.append @countTemplate(ProjectsCount.first().count)

  countTemplate: (count) ->
    @view('projects/count')(count: count)

window.Projector = Projector