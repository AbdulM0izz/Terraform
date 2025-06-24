output "instance_public_id" {
  value = aws_instance.ngnixServer.id
}

output "instance_url" {
  value = "https://${aws_instance.ngnixServer.public_ip}"
}