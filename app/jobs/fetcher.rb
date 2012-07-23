class Fetcher
  @queue = :projects

  def self.perform(uri, user_token)
    unless Project.redis.get uri
      json = JSON.parse(Net::HTTP.get(URI(uri))).to_json
      Project.redis.set uri, json
    end
    publish(JSON.parse(Project.redis.get(uri))["proposals"], user_token)
  end

private

  def self.publish(projects_json, user_token)
    Pusher[user_token].trigger(
      'projects_fetch', {
        projects: projects_json
      }
    )
  end
end