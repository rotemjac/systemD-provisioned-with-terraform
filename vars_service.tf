variable "home_dir" {
  default = "/root"
}

locals {
  path_postfix =  "/server/server.js"
  path         = "${local.git_repo_name}/${local.path_postfix}"
}


variable "service_user" {
  default = "root"
}

variable "service_group" {
  default = "root"
}

variable "pid_num" {
  default = 99
}

variable "execution_command" {
  default = "/usr/bin/node"
}

