terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.48.2"
    }
  }
}

variable "do_token" {
    type = string
    description = "Digital Ocean PAT"
}

provider "digitalocean" {
  token = var.do_token
}
