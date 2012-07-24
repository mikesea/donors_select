require 'net/http'

class Project

  API_KEY = 'DONORSCHOOSE'
  BASE_URI = "http://api.donorschoose.org/common/json_feed.html?max=50&APIKey=#{API_KEY}"

  class << self
    attr_writer :redis

    def redis
      @redis ||= $redis
    end
  end

  def self.find_by(params)
    uri = build_uri(params)
    if projects = redis.get(uri)
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