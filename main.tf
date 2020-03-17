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
