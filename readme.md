----------------------------------------

This repo is Loading a NodeJS application (Angular website served with nodeJS) as a SystemD service on a digital ocean cloud.

Notice that:
1. This is just for demonstration , for most cases, serve your WEB app with nginx or apache.
2. If you don't serve a website - remove the client part of script #2.
3. If you serve a website, but not with node - change the server part of script #2.
4. If your cloud vendor already give GIT out of the box - Delete script #0.

----------------------------------------

Steps to use this repo:

1. Create an API token for your digital ocean account.

2. Create an ssh key for the droplet

3. Run the script with the -p (path)' and -a (action) arguments':
```./run_tf.sh -p </path/to/your/ssh_keys> -a <terraform_action: init/plan/apply/destroy>```

4. Enter your repo password.

5. Enter your repo url (after the https://).

6. When ready you can connect with ssh (droplet IP is printed as output to terminal):
```ssh -i </path/to/your/id_rsa> root@<droplet-public-ip>```


----------------------------------------

There are many options to provision with terraform.
We need to think how we want to execute the scripts AND if we want the scripts to be written in a more modular fashion.

A few ideas:

For small scripts:
1. You can just write the all scripts as inline.
2. Pass them as 'user_data'.

If you want to break them into smaller distinguish scripts:

1. You can try what I did in this repo - break into template files and pass variables to it.
2. You can also use the terraform "file" provisioner to pass the scripts to the remote machines and execute the scripts there.
   Based on this:
   https://www.terraform.io/docs/provisioners/remote-exec.html#scripts

```
    // copy our example script to the server (you can use 'content' instead of source and use a template file)
    provisioner "file" {
      source      = "script.sh"
      destination = "/tmp/script.sh"
    }

    // change permissions to executable , run it and pass arguments (args) to it
    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/script.sh",
        "/tmp/script.sh args",
      ]
    }
```

3. You can build a template file (but a basic or empty one one) like we saw above as resource (or data - it doesn't matter) and pass variables to it and append scripts into it with "null_resource".
   At the end pass it to the remote machine and execute with "remote-exec":

```
resource "null_resource" "step1" {
  provisioner "local-exec" {
   command = <<EOF
       "echo ${replace(template_file.json.rendered, "\n", "")} > test.json"
       "python ./test.py testfilename test.json"
   EOF
  }
}

resource "null_resource" "step2" {
  provisioner "local-exec" {
   command = "echo ${replace(template_file.json.rendered, "\n", "")} > test.json"
  }
}
```




