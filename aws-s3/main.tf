terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "ran-id" {
  byte_length = 8
}

resource "aws_s3_bucket" "demoBucket" {
  bucket = "demobucketheyyr${random_id.ran-id.hex}"
}

resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.demoBucket.bucket
  source = "./myfile.txt"
  key = "bucketdata.txt"
}
