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

resource "aws_s3_bucket" "terraformstaticweb" {
  bucket = "terraformstaticweb${random_id.ran-id.hex}"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.terraformstaticweb.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.terraformstaticweb.id
  policy = jsonencode(
    {
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action =   "s3:GetObject"
            Resource =  "arn:aws:s3:::${aws_s3_bucket.terraformstaticweb.id}/*"
        }
    ]
}
  )
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.terraformstaticweb.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "webapp" {
  bucket = aws_s3_bucket.terraformstaticweb.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

output "name" {
  value = aws_s3_bucket_website_configuration.webapp.website_endpoint
}
