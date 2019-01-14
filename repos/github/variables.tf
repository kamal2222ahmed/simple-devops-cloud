variable "github_organization" {
  description = "Github Organization"
  type        = "string"
}
variable "github_token" {
  description = "Github Token"
  type        = "string"
}

variable  "github_users" { 
  description = "Create/Add Github Users"
  type = "list"
  default = ["knoxknot"] 
}

variable "simple_devops_repos" {
  description = "Repositories Belonging to Simple Devops Team"
  type        = "list"

  default = [
    "simple-devops-app",
    "simple-devops-cloud",
    "simple-devops-provision", 
  ]
}

variable "simple_devops_project" {
  default     = "simple-devops"
  description = "The Project Name"
  type        = "string"
}

variable "simple_devops_users" {
  description = "Create/Add Github Users"
  type        = "list"
  default     = ["knoxknot"]
}