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
    Projector.bind "paginate", @submitAPIRequest
    Clearer.bind "clearFilters", @submitAPIRequest

  submitAPIRequest: =>
    paginate = $("#paginate").attr('data-api-params')
    state = $("#state-button").attr('data-api-params')
    subject = $("#subject-button").attr('data-api-params')
    grade = $("#grade-button").attr('data-api-params')
    @addClearer()
    @loading()
    $.ajax
      type: 'get',
      url: 'projects.json',
      data: state + "&" + subject + "&" + grade + "&" + paginate
      success: (projects) ->
        Project.deleteAll()
        if projects.length > 0
          $(".projects-list").empty()      
        for project in projects
          Project.create(project, {ajax: false})

    $.ajax
      type: 'get',
      url: 'projects_counts.json',
      data: state + "&" + subject + "&" + grade + "&" + paginate
      success: (data) ->
        ProjectsCount.deleteAll()
        if data.count > 0
          ProjectsCount.create(data, {ajax: false})

  loading: ->
    $(".projects-count").empty()
    $(".projects-count").append "<h1>Loading projects...</h1>"
    $(".projects-list").empty()
    $(".projects-list").append @view('projects/loading')
    $("#paginate-next").hide()
    $("#paginate-previous").hide()

  addClearer: ->
    state = $("#state-button").attr('data-api-params')
    subject = $("#subject-button").attr('data-api-params')
    grade = $("#grade-button").attr('data-api-params')
    if state.length > 0 || subject.length > 0 || grade.length > 0
      unless $("#clear-filters").is(':visible')
        $("#clear-filters").fadeIn()

  filterByState: (e) ->
    @setActiveButton('#state-button')
    @filterActions.removeAttr('style')
    visibleElements = $(".filter-actions > *").filter(":visible")
    if visibleElements.size() == 1 && visibleElements[0].id == "map-container"
      $(".filter_button").removeClass("active")
      $("#map-container").slideUp("slow")
    else if visibleElements.size() == 0
      @showMap()
    else
      visibleElements.slideUp("slow")
      @showMap()

  showMap: ->
    $("#map-container").hide().slideDown("slow")
    priorstate = ""
    $("#map").usmap click: (event, data) =>
      if priorstate.name == data.name
        clearPriorState(data)
        $("#state-button").attr({'data-api-params':""})
        $("#state-button .state_text").text("State")
        priorstate = ""
        Filterer.trigger "clearIndex"
        @submitAPIRequest()
      else
        if priorstate
          clearPriorState(priorstate)
        fillStateAreas(data)
        $("#state-button .state_text").text "State: "+data.name
        $("#state-button").attr({'data-api-params': 'filters[]=state='+data.name})
        priorstate = data
        Filterer.trigger "clearIndex"
        @submitAPIRequest()
      
  clearPriorState = (priorstate) ->
    emptyStateColor = "#333"
    priorstate.hitArea.attr({fill: emptyStateColor, opacity: 0})
    if priorstate.labelHitArea
      priorstate.labelHitArea.attr({fill: emptyStateColor, opacity: 0})

  fillStateAreas = (state) ->
    stateColor = "#FFB71F"
    state.hitArea.attr({fill: stateColor, opacity: 1})
    if state.labelHitArea
      state.labelHitArea.attr({fill: stateColor, opacity: 1})

  filterBySubject: (e) ->
    @setActiveButton('#subject-button')
    @filterActions.removeAttr('style')
    visibleElements = $(".filter-actions > *").filter(":visible")
    if visibleElements.size() == 1 && visibleElements[0].id == "subject-buttons-container"
      $(".filter_button").removeClass("active")
      $("#subject-buttons-container").slideUp("slow")
    else if visibleElements.size() == 0
      $("#subject-buttons-container").hide().slideDown("slow")
    else
      visibleElements.slideUp("slow")
      $("#subject-buttons-container").hide().slideDown("slow")

  filterByGrade: (e) ->
    @setActiveButton("#grade-button")
    @filterActions.removeAttr('style')
    visibleElements = $(".filter-actions > *").filter(":visible")
    if visibleElements.size() == 1 && visibleElements[0].id == "grade-buttons-container"
      $(".filter_button").removeClass("active")
      $("#grade-buttons-container").slideUp("slow")
    else if visibleElements.size() == 0
      $("#grade-buttons-container").hide().slideDown("slow")
    else
      visibleElements.slideUp("slow")
      $("#grade-buttons-container").hide().slideDown("slow")

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button .grade_text").text(grade_button.attr('id'))
    $("#grade-button").attr({'data-api-params': grade_button.attr('data-api-params')})
    Filterer.trigger "clearIndex"
    @submitAPIRequest()

  showSubSubjects: (e) ->
    subject_button = $(e.target)
    $(".subject").removeClass("active")
    $(".sub-subject").removeClass("active")
    $(".special-needs").removeClass("active")
    $("#subject-buttons-container").slideUp("slow")
    $(".sub-subjects-container").hide()
    subject_button.addClass("active")
    sub_subject = subject_button.attr('id')
    sub_subject_buttons = $("div##{sub_subject}_subjects")
    sub_subject_buttons.slideDown("slow")
    $("#subject-button .subject_text").text(subject_button.text())
    $("#subject-button").attr({'data-api-params': subject_button.attr('data-api-params')})
    $("#subject-button").removeClass("append_sub_subject")
    Filterer.trigger "clearIndex"
    @submitAPIRequest()

  showSpecialNeeds: (e) ->
    $("#subject-button .subject_text").text("Special Needs")
    $("#subject-button").attr({'data-api-params': $(e.target).attr('data-api-params')})
    $(".sub-subjects-container").hide()
    $(".subject").removeClass("active")
    $(e.target).addClass("active")
    Filterer.trigger "clearIndex"
    @submitAPIRequest()

  changeButtonText: (e) ->
    $(".sub-subject").removeClass("active")
    $('.add-sub-subject').remove()
    sub_subject_button = $(e.target)
    sub_subject_button.addClass("active")
    $("#subject-button .subject_text").append("<span class='add-sub-subject'><hr/>#{sub_subject_button.text()}</span>")
    $("#subject-button").addClass("append_sub_subject")
    $("#subject-button").attr({'data-api-params': sub_subject_button.attr('data-api-params')})
    Filterer.trigger "clearIndex"
    @submitAPIRequest()

  setActiveButton: (selector) ->
    $(".filter_button").removeClass("active") 
    $(selector).addClass("active")

window.Filterer = Filterer
