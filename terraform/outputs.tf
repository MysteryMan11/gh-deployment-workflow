output "instance_ip" {
  description = "Public IPv4 address of Linode instance (first ipv4)"
  value = element(linode_instance.app.ipv4, 0)
}
