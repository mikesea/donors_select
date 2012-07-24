class Fetcher
  @queue = :fetch

  def self.perform(uri, user_token)
    unless is_set?(uri)
      response = fetch_projects(uri)
      response_json = JSON.parse(response)
      $redis.set uri, response_json.to_json
    end
    json = JSON.parse($redis.get(uri))
    Resque.enqueue Publisher, json, user_token if user_token
  end

private

  def self.is_set?(uri)
    $redis.keys.include? uri
  end

  def self.fetch_projects(uri)
    Net::HTTP.get(URI(uri))
  end

end