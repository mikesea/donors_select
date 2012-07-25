module ProjectsHelper
  def pusher_meta_tags
    tag('meta', name: 'pusher-key', content: Pusher.key)
  end

  def token_meta_tag
    tag('meta', name: 'session-token', content: session_token)
  end
end