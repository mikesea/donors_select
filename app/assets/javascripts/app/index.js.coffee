#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

# class Filterer extends Spine.Controller
#   @extend(Spine.Events)
# 
#   elements:
#     ".filter-actions" : "filterActions"
# 
#   events:
#     "click #state-button" : "filterByState"
# 
#   constructor: ->
#     super
# 
#   filterByState: (e) ->
#     @filterActions.empty()
#     @filterActions.append @view('filters/states')
# 
# window.Filterer = Filterer
