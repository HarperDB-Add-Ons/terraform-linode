terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.27.1"
    }
  }
}

provider "linode" {
  token = var.token
}

resource "linode_instance" "harperdb" {
  image = "linode/ubuntu18.04"
  region = "us-east"
  type = "g6-standard-1"
  root_pass = var.root_pass
}

resource "linode_firewall" "harperdb_firewall" {
  label = "harperdb"

  inbound {
    label    = "ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "harperdb"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "9925-9926"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.harperdb.id]
}