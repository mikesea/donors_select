class Projector extends Spine.Controller

  elements:
    ".projects-list" : "projects"

  constructor: ->
    super
    Project.bind "refresh", @addAll
    Project.fetch()

  addAll: =>
    @projects.empty()
    for project in Project.all()
      @addOne(project)

  addOne: (project) ->
    @projects.append @template(project)

  template: (project) ->
    @view('projects/project')(project: project)

window.Projector = Projector