if @data
  json.count @data["totalProposals"].to_i
  json.index @data["index"].to_i
end