provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "agent1-s3-inform"
  force_destroy = true

  tags = {
    Name = "mybucket"
    Envoirment = "dev"
  }
}
 resource "aws_instance" "server" {
   ami = "ami-0fc5d935ebf8bc3bc"
   instance_type = lookup(var.instance_type,terraform.workspace,"error")
 }