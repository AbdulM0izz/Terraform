resource "aws_instance" "ngnixServer" {
  ami                         = "ami-042b4708b1d05f512"  # Ubuntu 22.04 LTS
  instance_type               = "t3.nano"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ngnix_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "ngnixServer"
  }
}
