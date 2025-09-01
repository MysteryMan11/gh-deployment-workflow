output "instance_ip" {
  description = "Public IPv4 address of Linode instance"
  value       = linode_instance.app.ip_address
}
