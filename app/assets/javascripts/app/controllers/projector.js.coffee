class Projector extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".projects-list" : "projects"
    ".projects-count" : "count"

  events:
    "click .project-image" : "showInfo"
    "click .close-button" : "hideRecommendation"
    "click #paginate-next" : "paginateNext"
    "click #paginate-previous" : "paginatePrevious"

  constructor: ->
    super
    Filterer.bind "clearIndex", @clearIndex
    Project.bind 'create', @addProject
    Project.bind 'refresh', @addAll
    Project.bind "refresh", @makeRecommendation
    Project.bind "create", @makeRecommendation
    ProjectsCount.bind "refresh", @showPagination
    ProjectsCount.bind "create", @showPagination
    ProjectsCount.bind "refresh", @updateCount
    ProjectsCount.bind "create", @updateCount
    Project.fetch()
    ProjectsCount.fetch()

  showPagination: ->
    projects = ProjectsCount.first()
    if projects.index > 0
      $("#paginate-previous").show()
    else
      $("#paginate-previous").hide()

    if projects.count < 20 || projects.count < (projects.index+20)
      $("#paginate-next").hide()
    else
      $("#paginate-next").show()

  clearIndex: ->
    $("#paginate").attr('data-index', "0")
    $("#paginate").attr('data-api-params', "filters[]=index=0" )

  paginateNext: (e) ->
    e.preventDefault()
    oldIndex = parseInt($("#paginate").attr('data-index'))
    newIndex = oldIndex + 20
    $("#paginate").attr('data-index', newIndex )
    $("#paginate").attr('data-api-params', "filters[]=index=#{newIndex}" )
    Projector.trigger "paginate"

  paginatePrevious: (e) ->
    e.preventDefault()
    oldIndex = parseInt($("#paginate").attr('data-index'))
    return false if oldIndex == 0

    newIndex = oldIndex - 20
    $("#paginate").attr('data-index', newIndex )
    $("#paginate").attr('data-api-params', "filters[]=index=#{newIndex}" )
    Projector.trigger "paginate"    

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
