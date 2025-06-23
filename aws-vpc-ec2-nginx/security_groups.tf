resource "aws_security_group" "ngnix_sg" {
  vpc_id = aws_vpc.ngnix_vpx.id
  #Inbound rules
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Outbound rules
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ngnix-sg"
  }
}