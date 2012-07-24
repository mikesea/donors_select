class Publisher
  @queue = :publish

  def self.perform(projects_json, user_token)
    Pusher[user_token].trigger(
      'projects_fetch', {
        projects: projects_json
      }
    )
  end

end