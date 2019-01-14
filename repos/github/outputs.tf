# URL for Simple DevOps App
output "app_html_url" {
  value = "${github_repository.simple_devops_app.html_url}"
}

output "app_https_clone_url" {
  value = "${github_repository.simple_devops_app.http_clone_url}"
}

output "app_ssh_clone_url" {
  value = "${github_repository.simple_devops_app.ssh_clone_url}"
}

# URL for Simple DevOps Cloud
output "cloud_html_url" {
  value = "${github_repository.simple_devops_cloud.html_url}"
}

output "cloud_https_clone_url" {
  value = "${github_repository.simple_devops_cloud.http_clone_url}"
}

# URL for Simple DevOps Provision
output "provision_html_url" {
  value = "${github_repository.simple_devops_provision.html_url}"
}

output "provision_https_clone_url" {
  value = "${github_repository.simple_devops_provision.http_clone_url}"
}

