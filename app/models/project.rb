require 'net/http'

class Project
  def self.test_data
    base_uri = 'http://api.donorschoose.org/common/json_feed.html?state=WA'
    JSON.parse(Net::HTTP.get(URI(base_uri)))
  end

end