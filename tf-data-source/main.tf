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

