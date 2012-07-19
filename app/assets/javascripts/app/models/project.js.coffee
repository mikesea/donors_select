class Project extends Spine.Model
  @configure 'Project', 'id', 'proposalURL', 'imageURL', 'title', 'shortDescription'
  @extend Spine.Model.Ajax

window.Project = Project