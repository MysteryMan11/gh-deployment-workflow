variable "linode_token" {
  description = "Linode API token (write access)"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key content (for root)"
  type        = string
}

variable "root_pass" {
  description = "Temporary root password for Linode (Linode requires a root password on create)"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Linode region"
  type        = string
  default     = "ap-west"
}

variable "instance_type" {
  description = "Linode plan (2GB Shared CPU)"
  type        = string
  default     = "g6-standard-2"
}

variable "image" {
  description = "Linode image slug"
  type        = string
  default     = "linode/ubuntu24.04"
}
