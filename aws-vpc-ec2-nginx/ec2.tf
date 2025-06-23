resource "aws_instance" "ngnixServer" {
    ami           = "ami-042b4708b1d05f512"
    instance_type = "t3.nano"
    subnet_id = aws_subnet.public_subnet.id
    tags = {
     Name = "ngnixServer"
    }
}