class Projector extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".projects-list" : "projects"
    ".projects-count" : "count"

  events:
    "mouseover .project-image" : "showInfo"
    "mouseout .project-image" : "hideInfo"

  constructor: ->
    super
    console.log @el
    Project.bind "refresh", @addAll
    ProjectsCount.bind "refresh", @updateCount
    Project.fetch()
    ProjectsCount.fetch()

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


  addSmall: (project) ->
    @projects.append @smallTemplate(project)

  addMedium: (project) ->
    @projects.append @mediumTemplate(project)

  addLarge: (project) ->
    @projects.append @largeTemplate(project)

  smallTemplate: (project) ->
    @view('projects/small_project')(project:
      project)

  mediumTemplate: (project) ->
    @view('projects/medium_project')(project:
      project)

  largeTemplate: (project) ->
    @view('projects/large_project')(project:
      project)

  updateCount: =>
    @count.empty()
    @count.append @countTemplate(ProjectsCount.first().count)

  countTemplate: (count) ->
    @view('projects/count')(count: count)

window.Projector = Projector