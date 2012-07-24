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
    Project.bind 'create', @addProject
    Project.bind 'refresh', @addAll
    Project.fetch()
    Project.bind "refresh", @makeRecommendation
    Project.bind "create", @makeRecommendation
    ProjectsCount.bind "refresh", @updateCount
    ProjectsCount.bind "create", @updateCount
    ProjectsCount.fetch()

  makeRecommendation: =>
    project = Project.first()
    project_id = Project.first().id
    $(".project-image").removeClass("no-filter")
    $("div[data-id='#{project_id}']").children().addClass("no-filter")
    @displayRecommendation(project)

  showInfo: (e) ->
    $('.spotlight-inner').empty()
    $('.project-image').removeClass("no-filter")
    $(e.target).addClass("no-filter")
    project_id = $(e.target).parent().attr('data-id')
    project = Project.find(project_id)
    @displayRecommendation(project)

  addAll: =>
    @projects.empty()
    for project in Project.all()
      @addProject(project)

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
