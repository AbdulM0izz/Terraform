resource "aws_vpc" "ngnix_vpx" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "ngnix_vpc"
  }
}

resource "aws_subnet" "private_subnet" {
     cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.ngnix_vpx.id
    tags = {
      Name = "private_subnet"
    }
}

resource "aws_subnet" "public_subnet" {
   cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.ngnix_vpx.id
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_internet_gateway" "ngnix_igw" {
  vpc_id = aws_vpc.ngnix_vpx.id
  tags = {
    Name = "ngnix_igw"
  }
}

resource "aws_route_table" "ngnix_rt" {
  vpc_id = aws_vpc.ngnix_vpx.id

  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.ngnix_igw.id
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.ngnix_rt.id
  subnet_id      = aws_subnet.public_subnet.id
}