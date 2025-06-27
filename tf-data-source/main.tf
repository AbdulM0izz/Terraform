terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "eu-north-1"
}

/*In this data block block we fetch details*/
data "aws_ami" "name" {
   most_recent = true
   owners = ["amazon"]

}

/*Security groups*/
# data "aws_security_group" "name" {
  
# }

//Vpc Id
data "aws_vpc" "name" {
  tags = {
    Name = "my_vpc"
  }
}

output "vpc_id" {
  value = data.aws_vpc.name.id
}

output "aws_ami" {
  value = data.aws_ami.name.id
}

resource "aws_instance" "myserver" {
    ami           = data.aws_ami.name.id
    instance_type = "t3.nano"
    tags = {
     Name = "terraform-datasource"
    }
}

