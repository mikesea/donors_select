require 'net/http'

class Project
  extend BuildUri
  def self.find_by(params)
    uri = build_uri(params)
    if projects = $redis.get(uri)
      JSON.parse projects
    end
  end

  def self.fetch_and_publish(params, user_token=nil)
    uri = build_uri(params)
    Resque.enqueue Fetcher, uri, user_token
  end
end
