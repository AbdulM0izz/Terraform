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

// Create VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

// Private Subnet
resource "aws_subnet" "privateSubnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "privateSubnet"
  }
}

// Public Subnet
resource "aws_subnet" "publicSubnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "publicSubnet"
  }
}

// Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "my_igw"
  }
}

// Routing Table
resource "aws_route_table" "mt_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

// Route Table Association
resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.mt_rt.id
  subnet_id = aws_subnet.publicSubnet.id
}
