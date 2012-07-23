class Projector extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".projects-list" : "projects"
    ".projects-count" : "count"

  events:
    "mouseover .project-image" : "showInfo"
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
    $('.test').empty()
    project_id = $(e.target).parent().attr('data-id')
    project = Project.find(project_id)
    @displayRecommendation(project)

  addAll: =>
    @projects.empty()
    for project in Project.all()
      if Project.all().length >= 144
        @addSmall(project)
      else if Project.all().length >= 64
        @addMedium(project)
      else
        @addLarge(project)

  checkRecommendation: =>
    if Project.all().length <= 1000
      @displayRecommendation(Project.first())

  addSmall: (project) =>
    @projects.append @smallTemplate(project)

  addMedium: (project) =>
    @projects.append @mediumTemplate(project)

  addLarge: (project) =>
    @projects.append @largeTemplate(project)

  displayRecommendation: (project) ->
    $('.test').empty()
    $('.test').append @recommendationTemplate(project)

  smallTemplate: (project) ->
    @view('projects/small_project')(project:
      project)

  mediumTemplate: (project) ->
    @view('projects/medium_project')(project:
      project)

  largeTemplate: (project) ->
    @view('projects/large_project')(project:
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