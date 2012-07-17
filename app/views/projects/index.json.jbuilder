json.(@projects) do |json, project|
  json.id project["id"]
  json.proposalURL project["proposalURL"]
  json.imageURL project["imageURL"]
  json.title project["title"]
  json.description project["shortDescription"]
end