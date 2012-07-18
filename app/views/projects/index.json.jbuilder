json.(@projects["proposals"]) do |json, project|
  json.id project["id"]
  json.proposalURL project["proposalURL"]
  json.imageURL project["imageURL"]
  json.title CGI::unescapeHTML(project["title"])
  json.description CGI::unescapeHTML(project["shortDescription"])
end