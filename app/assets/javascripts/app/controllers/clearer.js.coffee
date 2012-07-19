class Clearer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    "#clear-filters" : "clearerofFilters"

  events:
    "click #clear-filters" : "clearFilters"

  constructor: ->
    super

  clearFilters: (e) ->
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
    

window.Clearer = Clearer
