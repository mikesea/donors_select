class Project extends Spine.Model
  @configure 'Project', 'id', 'proposalURL', 'imageURL', 'title', 'shortDescription', 'description'
  @extend Spine.Model.Ajax

window.Project = Project