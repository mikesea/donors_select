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
    @el.height(730)
    @filterActions.empty().append @view('filters/states')
    priorstate = ""
    $("#map").usmap click: (event, data) =>
      clearPriorState(priorstate)
      fillStateAreas(data)
      $("#state-button .state_text").text "State: "+data.name
      $("#state-button").attr({'data-api-params': 'filters[]=state='+data.name})
      priorstate = data
      @submitAPIRequest()

  clearPriorState = (priorstate) ->
    if priorstate
      priorstate.hitArea.attr({fill:"#333", opacity: 0})
      if priorstate.labelHitArea
        priorstate.labelHitArea.attr({fill:"#333", opacity: 0})

  fillStateAreas = (state) ->
    state.hitArea.attr({fill:"#ff0000", opacity: 1})
    if state.labelHitArea
      state.labelHitArea.attr({fill:"#ff0000", opacity: 1})

  submitAPIRequest: ->
    state = $("#state-button").attr('data-api-params')
    subject = $("#subject-button").attr('data-api-params')
    grade = $("#grade-button").attr('data-api-params')
    $.ajax
      type: 'get',
      url: 'projects.json',
      data: state + "&" + subject + "&" + grade
      success: (projects) ->
        Project.deleteAll()
        $(".projects-list").empty()
        for project in projects
          Project.create(project, {ajax: false})

    @loading()

    $.ajax
      type: 'get',
      url: 'projects_counts.json',
      data: state + "&" + subject + "&" + grade
      success: (count) ->
        ProjectsCount.deleteAll()
        ProjectsCount.create(count, {ajax: false})

  loading: ->
    $(".projects-list").empty()
    $(".projects-list").append "<h1>Loading!</h1>"

  filterBySubject: (e) ->
    $(".filter_button").removeClass("active")
    $(".sub-subjects-container").remove()
    $("#subject-button").addClass("active")
    @el.height(310)
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    $(".filter_button").removeClass("active")
    $("#grade-button").addClass("active")
    @filterActions.empty()
    @el.height(220)
    @filterActions.append @view('filters/grades')

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button .grade_text").text(grade_button.attr('id'))
    $("#grade-button").attr({'data-api-params': grade_button.attr('data-api-params')})
    @submitAPIRequest()

  showSubSubjects: (e) ->
    subject_button = $(e.target)
    @el.height(480)
    $(".subject").removeClass("active")
    $(".sub-subject").removeClass("active")
    $(".special-needs").removeClass("active")
    $(".sub-subjects-container").hide()
    subject_button.addClass("active")
    sub_subject = subject_button.attr('id')
    sub_subject_buttons = $("div [id='#{sub_subject} subjects']")
    sub_subject_buttons.show()
    $("#subject-button .subject_text").text(subject_button.attr('id'))
    $("#subject-button").attr({'data-api-params': subject_button.attr('data-api-params')})
    $("#subject-button").addClass("shrink")
    @submitAPIRequest()

  showSpecialNeeds: (e) ->
    @el.height(310)
    $("#subject-button").removeClass("shrink")
    $("#subject-button .subject_text").text("Special Needs")
    $("#subject-button").attr({'data-api-params': $(e.target).attr('data-api-params')})
    $(".sub-subjects-container").hide()
    $(".subject").removeClass("active")
    $(e.target).addClass("active")
    @submitAPIRequest()

  changeButtonText: (e) ->
    $(".sub-subject").removeClass("active")
    sub_subject_button = $(e.target)
    sub_subject_button.addClass("active")
    if sub_subject_button.hasClass("short")
      $("#subject-button").removeClass("shrink")
    else
      $("#subject-button").addClass("shrink")
    $("#subject-button .subject_text").text(sub_subject_button.attr('id'))
    $("#subject-button").attr({'data-api-params': sub_subject_button.attr('data-api-params')})
    @submitAPIRequest()

window.Filterer = Filterer
