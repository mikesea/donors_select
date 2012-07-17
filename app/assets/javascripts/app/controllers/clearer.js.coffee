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
    $("#state-button").text("State")
    $("#subject-button").text("Subject")
    $("#grade-button").text("Grade")
    $("path").attr "class", "state"
    $("path").attr "fill", "#333"

window.Clearer = Clearer