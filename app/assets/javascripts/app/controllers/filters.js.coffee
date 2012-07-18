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
    "click .sub-subject" : "changeButtonText"

  constructor: ->
    super

  filterByState: (e) ->
    $(".filter_button").removeClass("active")
    $("#state-button").addClass("active")
    @el.height(700)
    @filterActions.empty().append @view('filters/states')
    $("#map").usmap click: (event, data) ->
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "]').attr({class:"state", fill:"#00000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "})
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "]').attr({fill: "#000000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "})
      $(event.originalEvent.target).attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; ", class: "active-state"})
      console.log (data.hitArea)
      northeastStateColorer(data.name)
      $("#state-button").text "State: "+data.name

  northeastStateColorer = (state) ->
    if state == "VT"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="220"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M844.34355,153.72643L843.53525,148.0683L841.14454,138.09663L840.4979,137.77331L837.588,136.48002L838.3963,133.57013L837.588,131.46854L834.88795,126.82856L835.85792,122.9487L835.04961,117.77555L832.6247,111.30911L831.81913,106.3866L858.06661,99.63916L858.39094,105.45824L860.33087,108.20648L860.33087,112.248L856.61267,116.28952L854.0261,117.42115L854.0261,118.55277L855.15772,120.33104L855.15772,128.89906L854.34942,138.11373L854.18776,142.96356L855.15772,144.25685L854.99606,148.78334L854.51108,150.56162L855.1717,152.12847L848.22029,153.5026Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
    else if state == "NH"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="230.5"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M880.79902,142.42476L881.66802,141.34826L882.75824,138.05724L880.21516,137.14377L879.73017,134.07221L875.85032,132.94059L875.527,130.19235L868.25225,106.75153L863.65083,92.208542L862.75375,92.203482L862.10711,93.820087L861.46047,93.335106L860.4905,92.365143L859.03556,94.305068L858.98709,99.337122L859.29874,105.00434L861.23866,107.75258L861.23866,111.7941L857.52046,116.85688L854.93389,117.98852L854.93389,119.12014L856.06552,120.89841L856.06552,129.46643L855.25721,138.6811L855.09555,143.53092L856.06552,144.82422L855.90386,149.35071L855.41887,151.12899L856.87382,152.01499L873.26374,147.32527L875.527,146.67863L877.06121,144.12627Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
    else if state == "MA"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="241"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M899.97704,173.85121L902.14896,173.16533L902.60622,171.45066L903.63502,171.56497L904.66382,173.85121L903.4064,174.30845L899.5198,174.42277ZM890.6035,174.65139L892.88972,172.02222L894.49009,172.02222L896.31908,173.50827L893.91854,174.53707L891.74662,175.56587ZM855.80437,152.6632L873.26374,148.46002L875.527,147.81338L877.62858,144.58017L881.36535,142.91686L884.25459,147.3297L881.82968,152.50284L881.50636,153.95778L883.44629,156.54435L884.57791,155.73605L886.35618,155.73605L888.61942,158.32261L892.49928,164.30405L896.05581,164.78903L898.31905,163.81907L900.09732,162.0408L899.28901,159.29258L897.18743,157.67597L895.73248,158.48427L894.76252,157.19099L895.2475,156.70601L897.34909,156.54435L899.12735,157.35265L901.06728,159.77756L902.03724,162.68745L902.36056,165.11235L898.15739,166.5673L894.27754,168.50722L890.39769,173.03372L888.45776,174.48866L888.45776,173.5187L890.88267,172.06375L891.36765,170.28549L890.55935,167.21394L887.64946,168.66888L886.84116,170.12383L887.32614,172.38707L885.25981,173.3875L882.51261,168.86037L879.11773,164.49553L877.04723,162.68306L870.51396,164.55926L865.42163,165.61005L843.59742,170.37904L843.19483,165.43441L843.84147,154.84564L849.01462,153.9565Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
    else if state == "RI"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="251.5"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M874.07001,179.82344L873.58706,175.61904L872.77876,171.2542L871.08133,165.35359L876.82028,163.81781L878.43688,164.94943L881.83176,169.31427L884.74063,173.76056L881.82968,175.29696L880.5364,175.1353L879.40478,176.91357L876.97987,178.85349Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
    else if state == "CT"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="262"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M873.19331,180.05038L872.56579,175.84599L871.75749,171.48115L870.14088,165.4997L865.989,166.40438L844.16479,171.17336L844.81143,174.48742L846.26638,181.76216L846.26638,189.84519L845.13475,192.10845L846.96715,194.21757L851.9225,190.81637L855.47903,187.58316L857.41895,185.48157L858.22726,186.12821L860.97548,184.67327L866.14862,183.54165Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
    else if state == "NJ"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="272.5"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M828.16036,190.33018L826.05878,192.75509L826.05878,195.82665L824.11884,198.8982L823.95718,200.51482L825.25048,201.8081L825.08882,204.23302L822.82556,205.36464L823.63386,208.11287L823.79552,209.2445L826.54376,209.56782L827.51372,212.15439L831.07026,214.57931L833.49517,216.19591L833.49517,217.00422L830.26196,220.07578L828.64535,222.33902L827.1904,225.08726L824.92715,226.38054L823.7147,227.10802L823.4722,228.32048L822.86297,230.92722L823.95524,233.17141L827.18845,236.0813L832.03826,238.34455L836.07977,238.99119L836.24143,240.44613L835.43313,241.41609L835.75645,244.16432L836.56475,244.16432L838.66634,241.73942L839.47464,236.8896L842.22287,232.84809L845.29442,226.38167L846.42604,220.88522L845.7794,219.75359L845.61774,210.37728L844.00113,206.98242L842.86951,207.79072L840.12128,208.11404L839.6363,207.62906L840.76793,206.65909L842.86951,204.71917L842.93257,203.62534L842.54818,200.1915L843.03316,197.44326L842.8715,195.34167L840.28493,194.21004L835.75843,193.24008L831.87857,192.10845Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
    else if state == "DE"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="283"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M822.35259,230.42318L822.94187,228.32048L822.96339,227.11557L821.69394,227.02719L819.59234,228.6438L818.13739,230.09874L819.59234,234.30193L821.8556,239.96005L823.95718,249.6597L825.5738,255.96448L830.58528,255.80282L836.7274,254.59089L834.46317,247.23587L833.4932,247.72085L829.93667,245.29595L828.15841,240.60779L826.21848,237.05126L823.95524,236.0813L821.85365,232.52477Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
    else if state == "MD"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="293.5"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M836.95336,255.30492L830.81223,256.59715L825.00642,256.75881L823.16286,249.6597L821.06127,239.96005L818.79801,234.30193L817.50963,229.9036L810.00361,231.52596L795.1274,234.34928L757.67597,241.90018L758.80727,246.91184L759.77723,252.56995L760.10055,252.24663L762.20215,249.82173L764.46539,247.20407L766.8903,246.58851L768.34526,245.13356L770.12352,242.54699L771.4168,243.19364L774.32669,242.87031L776.91327,240.76873L778.92016,239.31546L780.76539,238.83048L782.40974,239.96043L785.31963,241.41537L787.25955,243.19364L788.47201,244.72942L792.59436,246.42685L792.59436,249.33674L798.09082,250.63003L799.23526,251.17201L800.64716,249.14369L803.52913,251.11385L802.25096,253.59578L801.48569,257.58144L799.70743,260.16801L799.70743,262.2696L800.35407,264.04787L805.41802,265.40356L809.72912,265.34184L812.80066,266.31181L814.90225,266.63513L815.87221,264.53354L814.41727,262.43196L814.41727,260.65369L811.99236,258.5521L809.89078,253.05565L811.18406,247.72085L811.0224,245.61927L809.72912,244.32598C809.72912,244.32598,811.18406,242.70938,811.18406,242.06274C811.18406,241.41609,811.66904,239.96115,811.66904,239.96115L813.60897,238.66787L815.54889,237.05126L816.03387,238.02123L814.57893,239.63783L813.28565,243.35602L813.60897,244.48764L815.38723,244.81096L815.87221,250.30742L813.77063,251.27738L814.09395,254.83391L814.57893,254.67225L815.71055,252.73233L817.32716,254.51059L815.71055,255.80388L815.38723,259.19875L817.9738,262.59362L821.85365,263.0786L823.47026,262.2703L826.70681,266.45323L828.06516,266.98953L834.71883,264.19258L836.72641,260.16871ZM820.32087,264.28945L821.45249,266.7952L821.61415,268.57347L822.74578,270.43257C822.74578,270.43257,823.63492,269.54343,823.63492,269.22011C823.63492,268.89679,822.90745,266.14855,822.90745,266.14855L822.17997,263.80446Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
    else if state == "DC"
      $('rect[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][y="304"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})
      $('path[style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 0; cursor: pointer; "][d="M801.75695,253.84384L800.67992,252.20717L799.66604,251.36463L800.7653,249.74841L802.99814,251.25941Z"]').attr({fill: "#FF0000", style: "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); opacity: 1; cursor: pointer; "})

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

  showMathSubjects: (e) ->
    $("#math-science-subjects").show()
    $("#subject-buttons-container").hide()
    $("#subject-button").text("Math and Science")
    $("#subject-button").addClass("shrink")

  showMusicSubjects: (e) ->
    $("#music-art-subjects").show()
    $("#subject-buttons-container").hide()
    $("#subject-button").text("Music and the Arts")
    $("#subject-button").addClass("shrink")

  showLiteracySubjects: (e) ->
    $("#literacy-language-subjects").show()
    $("#subject-buttons-container").hide()
    $("#subject-button").text("Literacy and Language")
    $("#subject-button").addClass("shrink")

  showHistorySubjects: (e) ->
    $("#history-civics-subjects").show()
    $("#subject-buttons-container").hide()
    $("#subject-button").text("History and Civics")
    $("#subject-button").addClass("shrink")

  showSpecialNeeds: (e) ->
    $("#subject-button").removeClass("shrink")
    $("#subject-button").text("Special Needs")

  showAppliedLearningSubjects: (e) ->
    $("#applied-learning-subjects").show()
    $("#subject-buttons-container").hide()
    $("#subject-button").text("Applied Learning")
    $("#subject-button").addClass("shrink")

  showHealthSubjects: (e) ->
    $("#health-sports-subjects").show()
    $("#subject-buttons-container").hide()
    $("#subject-button").text("Health and Sports")
    $("#subject-button").addClass("shrink")

  changeButtonText: (e) ->
    sub_subject_button = $(e.target)
    $("#subject-button").text(sub_subject_button.attr('id'))

  gradeList: (e) ->
    $(".grade_button").removeClass("active")
    grade_button = $(e.target)
    grade_button.addClass("active")
    $("#grade-button").text(grade_button.attr('id'))
    console.log(grade_button.attr('id'))

window.Filterer = Filterer
