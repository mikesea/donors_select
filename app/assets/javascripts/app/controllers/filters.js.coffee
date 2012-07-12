class Filterer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".filter-actions" : "filterActions"

  events:
    "click #state-button" : "filterByState"
    "click #subject-button" : "filterBySubject"
    "click #subject-grade" : "filterBySGrade"

  constructor: ->
    super

  filterByState: (e) ->
    @filterActions.empty()
    @filterActions.append @view('filters/states')
    $("#map").usmap click: (event, data) ->
      console.log(data.name)

  filterBySubject: (e) ->
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    @filterActions.empty()
    @filterActions.append @view('filters/grades')


window.Filterer = Filterer
