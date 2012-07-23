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
    $(".projects-list").append @view('projects/loading')

  filterByState: (e) ->
    @setActiveButton('#state-button')
    @filterActions.empty().append @view('filters/state_loading_filler')
    @filterActions.append @view('filters/states')
    $("#map-container").hide().slideDown("slow")
    priorstate = ""
    $("#map").usmap click: (event, data) =>
      if priorstate.name == data.name
        clearPriorState(data)
        $("#state-button").attr({'data-api-params':""})
        $("#state-button .state_text").text("State")
        priorstate = ""
        @submitAPIRequest()
      else
        if priorstate
          clearPriorState(priorstate)
        fillStateAreas(data)
        $("#state-button .state_text").text "State: "+data.name
        $("#state-button").attr({'data-api-params': 'filters[]=state='+data.name})
        priorstate = data
        @submitAPIRequest()

  clearPriorState = (priorstate) ->
      priorstate.hitArea.attr({fill:"#333", opacity: 0})
      if priorstate.labelHitArea
        priorstate.labelHitArea.attr({fill:"#333", opacity: 0})

  fillStateAreas = (state) ->
    state.hitArea.attr({fill:"#FFB71F", opacity: 1})
    if state.labelHitArea
      state.labelHitArea.attr({fill:"#FFB71F", opacity: 1})

  filterBySubject: (e) ->
    @setActiveButton('#subject-button')
    $(".sub-subjects-container").remove()
    @filterActions.empty().append @view('filters/grade_loading_filler')
    @filterActions.append @view('filters/subjects')
    $("#subject-buttons-container").hide().slideDown("slow")

  filterByGrade: (e) ->
    @setActiveButton("#grade-button")
    @filterActions.empty().append @view('filters/grade_loading_filler')
    @filterActions.append @view('filters/grades')
    $("#grade_buttons").hide().slideDown("slow")

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button .grade_text").text(grade_button.attr('id'))
    $("#grade-button").attr({'data-api-params': grade_button.attr('data-api-params')})
    @submitAPIRequest()

  showSubSubjects: (e) ->
    subject_button = $(e.target)
    $(".subject").removeClass("active")
    $(".sub-subject").removeClass("active")
    $(".special-needs").removeClass("active")
    $("#subject-buttons-container").hide()
    $(".sub-subjects-container").hide()
    subject_button.addClass("active")
    sub_subject = subject_button.attr('id')
    sub_subject_buttons = $("div##{sub_subject}_subjects")
    sub_subject_buttons.show()
    $("#subject-button .subject_text").text(subject_button.text())
    $("#subject-button").attr({'data-api-params': subject_button.attr('data-api-params')})
    $("#subject-button").addClass("shrink")
    @submitAPIRequest()

  showSpecialNeeds: (e) ->
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
    $("#subject-button .subject_text").text(sub_subject_button.text())
    $("#subject-button").attr({'data-api-params': sub_subject_button.attr('data-api-params')})
    @submitAPIRequest()

  setActiveButton: (selector) ->
    $(".filter_button").removeClass("active") 
    $(selector).addClass("active")

window.Filterer = Filterer
