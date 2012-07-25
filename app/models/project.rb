require 'net/http'

class Project
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

  def self.build_uri(params=nil)
    if params
      BASE_URI + "&" + params.join("&")
    else
      BASE_URI
    end
  end
end
