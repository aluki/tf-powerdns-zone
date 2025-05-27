terraform {
  required_version = "~> 1.8"
  required_providers {
    powerdns = {
      source = "pan-net/powerdns"
      version = "~> 1.5"
    }
    dns = {
      source = "hashicorp/dns"
      version = "~> 3.4"
    }
    external = {
      source = "hashicorp/external"
      version = "~> 2.3"
    }
  }
}

provider "dns" {
  update {
    server = var.dns_host
    port = var.dns_port
  }
}
