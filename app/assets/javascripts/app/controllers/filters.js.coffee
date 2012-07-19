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
      fillStateAreas(data)
      $("#state-button").text "State: "+data.name
      priorstate = data

  clearPriorState = (priorstate) ->
    if priorstate
      priorstate.hitArea.attr({fill:"#333", opacity: 0})
      if priorstate.labelHitArea
        priorstate.labelHitArea.attr({fill:"#333", opacity: 0})

  fillStateAreas = (state) ->
    state.hitArea.attr({fill:"#ff0000", opacity: 1})
    if state.labelHitArea
      state.labelHitArea.attr({fill:"#ff0000", opacity: 1})

  filterBySubject: (e) ->
    $(".filter_button").removeClass("active")
    $(".sub-subjects-container").hide()
    $("#subject-button").addClass("active")
    @el.height(275)
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    $(".filter_button").removeClass("active")
    $("#grade-button").addClass("active")
    @filterActions.empty()
    @el.height(200)
    @filterActions.append @view('filters/grades')

  showSubSubjects: (e) ->
    subject_button = $(e.target)
    # unless subject_button.hasClass("active")
    @el.height(450)
    $(".subject").removeClass("active")
    $(".sub-subject").removeClass("active")
    $(".special-needs").removeClass("active")
    $(".sub-subjects-container").hide()
    subject_button.addClass("active")
    subject_buttons = subject_button.next()
    subject_buttons.insertAfter("#subject-buttons-container")
    subject_buttons.show()
    $("#subject-button").text(subject_button.attr('id'))
    $("#subject-button").addClass("shrink")

  showSpecialNeeds: (e) ->
    @el.height(275)
    $("#subject-button").removeClass("shrink")
    $("#subject-button").text("Special Needs")
    $(".sub-subjects-container").hide()
    $(".subject").removeClass("active")
    $(e.target).addClass("active")

  changeButtonText: (e) ->
    $(".sub-subject").removeClass("active")
    sub_subject_button = $(e.target)
    sub_subject_button.addClass("active")
    if sub_subject_button.hasClass("short")
      $("#subject-button").removeClass("shrink")
    else
      $("#subject-button").addClass("shrink")
    $("#subject-button").text(sub_subject_button.attr('id'))

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button").text(grade_button.attr('id'))
    console.log(grade_button.attr('id'))

window.Filterer = Filterer
