### Set a Provider ###
provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}

### Add a Team to the Organization ###
resource "github_team" "simple_devops_team" {
  name        = "simple-devops-team"
  description = "The Simple DevOps Project Team"
  privacy     = "closed"
}

# Simple DevOps Team Members
resource "github_team_membership" "simple_devops_members" {
  team_id  = "${github_team.simple_devops_team.id}"
  count    = "${length(var.simple_devops_users)}"
  username = "${element(var.simple_devops_users, count.index)}"
  role     = "${element(var.simple_devops_users, count.index) == "knoxknot" ? "maintainer" : "member"}"
}

### Create Repositories ###
# Simple DevOps Provisioner
resource "github_repository" "simple_devops_provision" {
  name        = "${var.simple_devops_project}-provision"
  description = "The Codebase for Configuring the Servers"
}

# Simple DevOps Application
resource "github_repository" "simple_devops_app" {
  name        = "${var.simple_devops_project}-app"
  description = "The Simple DevOps Project Application Codebase"
}

# Simple DevOps Cloud Architecture
resource "github_repository" "simple_devops_cloud" {
  name        = "${var.simple_devops_project}-cloud"
  description = "The Simple DevOps Project Cloud Codebase"
}

### Add Repositories to a Team ###
# Simple DevOps Team
resource "github_team_repository" "simple_devops_repos" {
  team_id  = "${github_team.simple_devops_team.id}"
  count  =  "${length(var.simple_devops_repos)}" 
  repository = "${element(var.simple_devops_repos, count.index)}" 
  permission = "push"
}