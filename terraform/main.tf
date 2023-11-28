provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
    bucket = "paras-bucket-xyz"
    force_destroy = true
  
}
resource "aws_instance" "example" {
  ami    = var.ami_id
  instance_type = var.instance_type
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "main" {
  vpc_id                    = aws_vpc.myvpc.id
  cidr_block                = "10.0.1.0/24"
  availability_zone         = "us-east-1b"
  map_public_ip_on_launch   = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "RTa1" {
  subnet_id = aws_subnet.main.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "webSg" {
  name = "allow tls"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "TLS from vpc"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP from vpc"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_dynamodb_table" "terraform-lock" {
  name          = "terraform-lock"
  billing_mode  = "PAY_PER_REQUEST"
  hash_key      = "LockID"
  

  attribute {
    name = "LockID"
    type = "S"
  }
}


