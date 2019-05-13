### DNS ###
variable "domain_name" {
  default = "rotem-jack.com"
}


### NOTICE!! All name servers must end up with a DOT , or you will get this 422 error: https://github.com/terraform-providers/terraform-provider-digitalocean/issues/58
variable "name_servers" {
  type = "list",
  default = [
    "ns1.digitalocean.com.",
    "ns2.digitalocean.com.",
    "ns3.digitalocean.com."
  ]
}
