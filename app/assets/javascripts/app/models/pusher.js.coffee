#= require pusher

$ = jQuery

class PusherHandler extends Spine.Module

  constructor: (@options = {}) ->
    @options.key or= $('meta[name=pusher-key]').attr('content')

    @pusher = new Pusher(@options.key)

    $.ajaxSetup
      beforeSend: (xhr) =>
        xhr.setRequestHeader 'X-Session-ID', @pusher.connection.socket_id

    @channel = @pusher.subscribe $('meta[name=session-token]').attr('content')
    @channel.bind_all @processWithoutAjax

  process: (type, msg) =>
    projects = $(".projects-list")
    projectsCount = $(".projects-count")
    
    switch type
      when 'projects_fetch'
        Project.deleteAll()
        projects.empty()
        projectsCount.empty()
        projectsCount.append "<h1>#{msg.projects.totalProposals} matching projects</h1>"
        for project in msg.projects.proposals
          Project.create(project)
      else
        return false

  processWithoutAjax: =>
    args = arguments
    Spine.Ajax.disable =>
      @process(args...)

$ -> new PusherHandler