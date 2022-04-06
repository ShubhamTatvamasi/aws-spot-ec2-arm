output "public_ip" {
  value = module.ec2_instance.public_ip
}

output "private_dns_name" {
  value = aws_network_interface.second_interface.0.private_dns_name
}
