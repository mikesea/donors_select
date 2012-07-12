class Filterer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".filter-actions" : "filterActions"

  events:
    "click #state-button" : "filterByState"

  constructor: ->
    super

  filterByState: (e) ->
    @filterActions.empty()
    @filterActions.append @view('filters/states')

window.Filterer = Filterer
