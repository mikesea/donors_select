class Fetcher
  @queue = :fetch

  def self.perform(uri, user_token)
    unless is_set?(uri)
      response = fetch_projects(uri)
      $redis.set uri, response.to_json
    end
    publish(uri, user_token)
  end

private

  def self.is_set?(uri)
    $redis.keys.include? uri
  end

  def self.fetch_projects(uri)
    response = Net::HTTP.get(URI(uri))
    JSON.parse(response)
  end

  def self.publish(uri, user_token)
    json = JSON.parse($redis.get(uri))
    Resque.enqueue Publisher, json, user_token
  end

end