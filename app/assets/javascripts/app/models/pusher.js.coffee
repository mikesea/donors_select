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
        ProjectsCount.deleteAll()
        projects.empty()
        ProjectsCount.create
          count: parseInt(msg.projects.totalProposals)
          index: parseInt(msg.projects.index)
        for project in msg.projects.proposals
          Project.create(project)
      else
        return false

  processWithoutAjax: =>
    args = arguments
    Spine.Ajax.disable =>
      @process(args...)

$ -> new PusherHandler