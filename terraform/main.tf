terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "linode" {
  token = var.linode_token
}

resource "random_id" "hex" {
  byte_length = 4
}

resource "linode_sshkey" "deployer" {
  label   = "github-actions-key"
  ssh_key = var.ssh_public_key
}

resource "linode_instance" "app" {
  label           = "node-app-${random_id.hex}"
  region          = var.region
  type            = var.instance_type     # g6-standard-2
  image           = var.image             # linode/ubuntu24.04
  authorized_keys = [linode_sshkey.deployer.ssh_key]
  root_pass       = var.root_pass

  tags = ["node-app"]
}

resource "linode_firewall" "nodeapp_fw" {
  label = "nodeapp-fw"

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "allow-ssh"
    protocol = "TCP"
    ports    = "22"                       # string, not list
    ipv4     = ["0.0.0.0/0"]              # use ipv4 (list of CIDRs)
  }

  inbound {
    label    = "allow-node"
    protocol = "TCP"
    ports    = "3000"                     # string, not list
    ipv4     = ["0.0.0.0/0"]
  }

  inbound {
    label    = "allow-node"
    protocol = "TCP"
    ports    = "8080"
    ipv4     = ["0.0.0.0/0"]
  }

  # attach the Linode by ID
  linodes = [linode_instance.app.id]
}
