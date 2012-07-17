class Filterer extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".filter-actions" : "filterActions"

  events:
    "click #state-button" : "filterByState"
    "click #subject-button" : "filterBySubject"
    "click #grade-button" : "filterByGrade"
    "click .grade_button" : "gradeList"
    "click #math-science-button" : "showMathSubjects"
    "click #music-arts-button" : "showMusicSubjects"
    "click #literacy-language-button" : "showLiteracySubjects"
    "click #history-civics-button" : "showHistorySubjects"
    "click #special-needs-button" : "showSpecialNeeds"
    "click #applied-learning-button" : "showAppliedLearningSubjects"
    "click #health-sports-button" : "showHealthSubjects"

  constructor: ->
    super

  filterByState: (e) ->
    @filterActions.empty()
    @el.height(700)
    @filterActions.append @view('filters/states')
    $("#map").usmap click: (event, data) ->
      $("path").attr("class", "state")
      $("path").attr("fill", "#333")
      $(event.originalEvent.target).attr("fill", "#FF0000")
      $(event.originalEvent.target).attr("style", "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; ")
      $(event.originalEvent.target).attr("class","active-state");
      console.log($(event.originalEvent.target))
      $("#state-button").text(data.name)

  filterBySubject: (e) ->
    @el.height(200)
    @filterActions.empty()
    @filterActions.append @view('filters/subjects')

  filterByGrade: (e) ->
    @filterActions.empty()
    @el.height(200)
    @filterActions.append @view('filters/grades')

  showMathSubjects: (e) ->
    $("#math-science-subjects").show()
    $(".subject").hide()
    $("#subject-button").text("Math and Science")

  showMusicSubjects: (e) ->
    $("#music-art-subjects").show()
    $(".subject").hide()
    $("#subject-button").text("Music and the Arts")

  showLiteracySubjects: (e) ->
    $("#literacy-language-subjects").show()
    $(".subject").hide()
    $("#subject-button").text("Literacy and Language")

  showHistorySubjects: (e) ->
    $("#history-civics-subjects").show()
    $(".subject").hide()
    $("#subject-button").text("History and Civics")

  showSpecialNeeds: (e) ->
    $("#subject-button").text("Special Needs")

  showAppliedLearningSubjects: (e) ->
    $("#applied-learning-subjects").show()
    $(".subject").hide()
    $("#subject-button").text("Applied Learning")

  showHealthSubjects: (e) ->
    $("#health-sports-subjects").show()
    $(".subject").hide()
    $("#subject-button").text("Health and Sports")

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button").text(grade_button.attr('id'))
    console.log(grade_button.attr('id'))

window.Filterer = Filterer
