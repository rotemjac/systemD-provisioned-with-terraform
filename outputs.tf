# The droplet public IP
output "droplet_ip" {
  value = "${digitalocean_droplet.web-server.ipv4_address}"
}

# The FQDN for the record
output "fqdn" {
  value = "${digitalocean_record.www.fqdn}"
}

### For Debug ###
output "git_repo_postfix" {
  value = "${local.git_repo_postfix}"
}

output "git_repo_name" {
  value = "${local.git_repo_name}"
}

output "git_user" {
  value = "${local.git_user}"
}
