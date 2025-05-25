# https://registry.terraform.io/providers/linode/linode/latest/docs/data-sources/vpc
resource "linode_vpc" "alphabet_vpc" {
  label  = var.vpc_name
  region = var.region
}

resource "linode_vpc_subnet" "alphabet_vpc_subnet" {
  vpc_id = linode_vpc.alphabet_vpc.id
  label  = "${var.vpc_name}-subnet"
  ipv4   = "10.0.1.0/24"
}


resource "linode_firewall" "alphabet_firewall" {
  label = var.firewall_name

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  outbound {
    label    = "allow-all-outbound"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "1-65535"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }
  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"
}