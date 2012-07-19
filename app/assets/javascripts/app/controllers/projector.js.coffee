class Projector extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".projects-list" : "projects"
    ".projects-count" : "count"

  events:
    "mouseover .project-image" : "showInfo"
    "mouseout .project-image" : "hideInfo"
    "click .close-button" : "hideRecommendation"

  constructor: ->
    super
    Project.bind 'create', @addMedium
    Project.bind 'refresh', @addAll
    Project.fetch()
    # Project.bind "refresh", @addAll
    # Project.bind "refresh", @checkRecommendation
    # ProjectsCount.bind "refresh", @updateCount
    # ProjectsCount.fetch()

  showInfo: (e) ->
    $(e.target).first().parent().parent().next().show()

  hideInfo: (e) ->
    $(".project-info").hide()

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
    if Project.all().length <= 20
      @displayRecommendation(Project.first())

  addSmall: (project) =>
    @projects.append @smallTemplate(project)

  addMedium: (project) =>
    @projects.append @mediumTemplate(project)

  addLarge: (project) =>
    @projects.append @largeTemplate(project)

  displayRecommendation: (project) ->
    @projects.append @recommendationTemplate(project)

  hideRecommendation: ->
    $('.closer').hide()
    $(".recommendation").hide()

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