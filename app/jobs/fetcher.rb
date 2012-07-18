class Fetcher
  @queue = :projects

  def self.perform(uri)
    Project.redis.set uri, JSON.parse(Net::HTTP.get(URI(uri))).to_json
  end
end