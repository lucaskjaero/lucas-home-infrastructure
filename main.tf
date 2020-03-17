terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lucas-home-infrastructure"

    workspaces {
      name = "lucas-home-infrastructure"
    }
  }
}

variable "digitalocean_token" {}

provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_droplet" "lucas_proxy" {
  image      = "ubuntu-18-04-x64"
  name       = "lucas-proxy"
  region     = "sfo2"
  size       = "s-1vcpu-1gb"
  ssh_keys   = [26855236]
  monitoring = true
}

resource "digitalocean_firewall" "lucas_proxy_firewall" {
  name = "lucas-proxy-firewall"

  droplet_ids = [digitalocean_droplet.lucas_proxy.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/32"]
  }

  outbound_rule {
    protocol              = "tcp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
