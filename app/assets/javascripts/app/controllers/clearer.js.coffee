class Clearer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    "#clear-filters" : "clearerofFilters"

  events:
    "click #clear-filters" : "clearFilters"

  constructor: ->
    super

  clearFilters: (e) ->
    $(".filter-actions > *").filter(":visible").slideUp("slow")
    $(".filter_button").removeClass("active")
    $(".grade_button").removeClass("active")
    $(".sub-subject").removeClass("active")
    $(".subject").removeClass("active")
    $("#state-button .state_text").text("State")
    $("#grade-button .grade_text").text("Grade")
    $("#subject-button .subject_text").text("Subject")
    $("#subject-button").removeClass("append_sub_subject")
    $("#state-button").attr({'data-api-params':""})
    $("#subject-button").attr({'data-api-params':""})
    $("#grade-button").attr({'data-api-params':""})
    $("#clear-filters").fadeOut()
    $("path").attr "class", "state"
    $("path").attr "fill", "#333"

    Clearer.trigger "clearFilters"

window.Clearer = Clearer
