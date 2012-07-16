class Filterer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".filter-actions" : "filterActions"

  events:
    "click #state-button" : "filterByState"
    "click #subject-button" : "filterBySubject"
    "click #grade-button" : "filterByGrade"
    "click .grade_button" : "gradeList"
    # "click #math-science-button" : "showMathSubjects"
    "click .subject" : "subjectFilter"

  constructor: ->
    super

  filterByState: (e) ->
    @filterActions.empty()
    @el.height(700)
    @filterActions.append @view('filters/states')
    $("#map").usmap click: (event, data) ->
      console.log(data.name)

  filterBySubject: (e) ->
    @el.height(150)
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    @filterActions.empty()
    @el.height(200)
    @filterActions.append @view('filters/grades')

  subjectFilter: (e) ->
    console.log($(e.target))

  showMathSubjects: (e) ->
    $("#math-science-subjects").show()

  gradeList: (e) ->
    console.log($(e.target).attr('data-grade'))

window.Filterer = Filterer
