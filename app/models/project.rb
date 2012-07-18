require 'net/http'

class Project

  BASE_URI = 'http://api.donorschoose.org/common/json_feed.html'
  API_KEY = 'DONORSCHOOSE'

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
    else
      Resque.enqueue(Fetcher, uri)
    end
  end

  def self.build_uri(params=nil)
    params = [] unless params
    params << "APIKey=#{API_KEY}"
    BASE_URI + "?" + params.join("&")
  end

end