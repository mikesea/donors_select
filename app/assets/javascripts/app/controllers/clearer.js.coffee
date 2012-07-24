class Clearer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    "#clear-filters" : "clearerofFilters"

  events:
    "click #clear-filters" : "clearFilters"

  constructor: ->
    super

  clearFilters: (e) ->
    $(".filter-actions").slideUp("slow")
    $(".filter-actions").empty()
    $(".filter_button").removeClass("active")
    $(".grade_button").removeClass("active")
    $("#state-button .state_text").text("State")
    $("#grade-button .grade_text").text("Grade")
    $("#subject-button .subject_text").text("Subject")
    $("#subject-button").removeClass("shrink")
    $("#state-button").attr({'data-api-params':""})
    $("#subject-button").attr({'data-api-params':""})
    $("#grade-button").attr({'data-api-params':""})
    $("path").attr "class", "state"
    $("path").attr "fill", "#333"

    @submitAPIRequest()

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
    

window.Clearer = Clearer
