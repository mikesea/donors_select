class Filterer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".filter-actions" : "filterActions"

  events:
    "click #state-button" : "filterByState"
    "click #subject-button" : "filterBySubject"
    "click #grade-button" : "filterByGrade"
    "click .grade_button" : "gradeList"
    "click .special-needs" : "showSpecialNeeds"
    "click .subject" : "showSubSubjects"
    "click .sub-subject" : "changeButtonText"

  constructor: ->
    super

  filterByState: (e) ->
    $(".filter_button").removeClass("active")
    $("#state-button").addClass("active")
    @el.height(700)
    @filterActions.empty().append @view('filters/states')
    priorstate = ""
    $("#map").usmap click: (event, data) ->
      clearPriorState(priorstate)
      data.hitArea.attr({fill:"#ff0000", opacity: 1})
      if data.labelHitArea
        data.labelHitArea.attr({fill:"#ff0000", opacity: 1})
      priorstate = data
      $("#state-button").text "State: "+data.name

  clearPriorState = (priorstate) ->
    if priorstate
      priorstate.hitArea.attr({fill:"#333", opacity: 0})
      if priorstate.labelHitArea
        priorstate.labelHitArea.attr({fill:"#333", opacity: 0})

  filterBySubject: (e) ->
    $(".filter_button").removeClass("active")
    $("#subject-button").addClass("active")

    @el.height(250)
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    $(".filter_button").removeClass("active")
    $("#grade-button").addClass("active")
    @filterActions.empty()
    @el.height(200)
    @filterActions.append @view('filters/grades')

  showSubSubjects: (e) ->
    $("#subject-button").removeClass("shrink")
    subject_button = $(e.target)
    $(".subject").hide()
    $(".special-needs").hide()
    subject_button.next().show()
    $("#subject-button").text(subject_button.attr('id'))
    $("#subject-button").addClass("shrink")

  showSpecialNeeds: (e) ->
    $("#subject-button").removeClass("shrink")
    $("#subject-button").text("Special Needs")

  changeButtonText: (e) ->
    $(".sub-subject").removeClass("active")
    sub_subject_button = $(e.target)
    sub_subject_button.addClass("active")
    $("#subject-button").text(sub_subject_button.attr('id'))

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button").text(grade_button.attr('id'))
    console.log(grade_button.attr('id'))

window.Filterer = Filterer
