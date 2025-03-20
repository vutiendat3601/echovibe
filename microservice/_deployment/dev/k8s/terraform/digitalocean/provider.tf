terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
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
