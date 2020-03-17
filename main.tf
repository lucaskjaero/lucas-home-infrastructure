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
