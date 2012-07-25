require 'net/http'

class Project
  extend BuildUri
  
  def self.find_by(params)
    uri = build_uri(params)
    if projects = fetch_projects(uri)
      JSON.parse projects
    end
  end

  def self.fetch_and_publish(params, user_token=nil)
    uri = build_uri(params)
    queue_fetch_job(uri, user_token)
  end

  def self.fetch_projects(uri)
    $redis.get(uri)
  end

  def self.queue_fetch_job(uri, user_token)
    Resque.enqueue Fetcher, uri, user_token
  end
end
