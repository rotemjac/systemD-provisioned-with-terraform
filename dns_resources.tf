# Create a new domain record
resource "digitalocean_domain" "my-dns-record" {
  name = "${var.domain_name}"
}

resource "digitalocean_record" "name_server" {
  count  = "${length(var.name_servers)}"
  domain = "${digitalocean_domain.my-dns-record.name}"
  type   = "NS"
  name   = "ns-${count.index}"

  value  = "${element(var.name_servers, count.index)}"
  ttl    = 60
}


resource "digitalocean_record" "www" {
  domain = "${var.domain_name}"
  type   = "A"
  name   = "www"
  value  = "${digitalocean_droplet.web-server.ipv4_address}"
  ttl    = 60
}