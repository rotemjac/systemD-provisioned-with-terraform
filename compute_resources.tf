resource "digitalocean_droplet" "web-server" {
  name   = "web-server"
  region = "${var.region}"
  image  = "${var.image}"
  size   = "${var.size_4_gb}"

  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file(var.pvt_key)}"
      agent = false
      timeout = "5m"
    }

    inline =

    ## For test - try a simple nginx server first
    #["apt-get update -y", "apt-get install -y nginx > /tmp/nginx.log"]

    <<EOF
        ${data.template_file.script_0.rendered}
        ${data.template_file.script_1.rendered}
        ${data.template_file.script_2.rendered}
        ${data.template_file.script_3.rendered}
      EOF
  }
}


### ------ Break script into smaller portions -------- ###

data "template_file" "script_0" {
  template = "${file("${path.module}/scripts/0_install_git_clone_repo.sh.tpl")}"
  vars {
    git_user      = "${local.git_user}",
    git_password  = "${var.git_password}",
    git_repo_path = "${var.git_repo_path}"
  }
}

data "template_file" "script_1" {
  template = "${file("${path.module}/scripts/1_install_node.sh.tpl")}"
}

data "template_file" "script_2" {
  template = "${file("${path.module}/scripts/2_install_service_dep.sh.tpl")}"
  vars {
    home_dir       = "${var.home_dir}",
    git_repo_name  = "${local.git_repo_name}"
  }
}

data "template_file" "script_3" {
  template = "${file("${path.module}/scripts/3_create_service.sh.tpl")}"
  vars {
    home_dir          = "${var.home_dir}",
    path              = "${local.path}"
    service_name      = "${local.git_repo_name}",
    service_user      = "${var.service_user}",
    service_group     = "${var.service_group}",
    pid_num           = "${var.pid_num}"
    execution_command = "${var.execution_command}"
  }
}