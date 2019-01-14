variable "credentials_path" {
  description = "Path to Users AWS Credentials"
  type        = "string"
}
variable "profile" {
  description = "The AWS Profile in Credentials Path to Use"
  type        = "string"
}

variable "project" {
  description = "Project Name"
  type        = "string"
}

variable "region" {
  description = "AWS Region"
  type        = "string"
}