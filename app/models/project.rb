require 'net/http'

class Project
  def self.test_data

    counter_params = [
                       "&index=51&max=10",
                       "&index=101&max=10",
                     ]

    first_fifty = retrieve_data('http://api.donorschoose.org/common/json_feed.html?state=WA&max=50')
    first_fifty = JSON.parse(first_fifty)

    counter_params.each do |param|
      response = retrieve_data('http://api.donorschoose.org/common/json_feed.html?state=WA' + param)
      json_projects = JSON.parse(response)
      add_project(json_projects['proposals'], first_fifty['proposals'])
    end
    first_fifty
  end

  private

  def self.retrieve_data(uri)
    Net::HTTP.get(URI(uri))
  end

  def self.add_project(projects_to_add, master)
    projects_to_add.each do |project|
      master << project
    end
  end
end