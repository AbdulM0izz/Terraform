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

resource "aws_s3_bucket" "demoBucket" {
  bucket = "demobucketheyyr"
}

resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.demoBucket.bucket
  source = "./myfile.txt"
  key = "bucketdata.txt"
}