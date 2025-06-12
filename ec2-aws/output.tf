// get data after the creation of resource in terminal
output "aws_public_ip" {
  value = aws_instance.myserver.public_ip
}