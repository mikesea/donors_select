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
    return false unless msg

    switch type
      when 'projects_fetch'
        Project.deleteAll()
        $(".projects-list").empty()
        for project in msg.projects
          Project.create(project)
      else
        return false

  processWithoutAjax: =>
    args = arguments
    Spine.Ajax.disable =>
      @process(args...)

$ -> new PusherHandler