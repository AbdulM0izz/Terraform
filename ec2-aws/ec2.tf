variable "region" {
  description = "value of region"
  default = "eu-north-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
    ami           = "ami-042b4708b1d05f512"
    instance_type = "t3.nano"
    tags = {
     Name = "terraform"
    }
}