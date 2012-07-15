class Filterer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".filter-actions" : "filterActions"
    ".buttons_liner" : "buttonsLiner"
    "#map" : "usaMap"

  events:
    "click #state-button" : "filterByState"
    "click #subject-button" : "filterBySubject"
    "click #grade-button" : "filterByGrade"

  constructor: ->
    super

  filterByState: (e) ->
    @filterActions.empty()
    @buttonsLiner.height(700)
    @filterActions.append @view('filters/states')
    $("#map").usmap click: (event, data) ->
      console.log(data.name)

  filterBySubject: (e) ->
    @buttonsLiner.height(110)
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    @filterActions.empty()
    @buttonsLiner.height(200)
    @filterActions.append @view('filters/grades')    

  extendButtonsLiner: ->
    @buttonsLiner.height(200)
    console.log(@buttonsLiner)

  clearButtonEffects: ->
    @filterActions.empty()
    @buttonsLiner.height(100)

window.Filterer = Filterer