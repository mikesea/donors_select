class Projector extends Spine.Controller

  elements:
    ".projects-list" : "projects"
    ".projects-count" : "count"

  constructor: ->
    super
    console.log @el
    Project.bind "refresh", @addAll
    ProjectsCount.bind "refresh", @updateCount
    Project.fetch()
    ProjectsCount.fetch()

  addAll: =>
    @projects.empty()
    for project in Project.all()
      @addOne(project)

  addOne: (project) ->
    @projects.append @template(project)

  template: (project) ->
    @view('projects/project')(project: 
      project)

  updateCount: =>
    @count.empty()
    @count.append ProjectsCount.first().count  

window.Projector = Projector