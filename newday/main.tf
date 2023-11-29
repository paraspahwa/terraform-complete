provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "ami-0fc5d935ebf8bc3bc"
    "stag" = "ami-0fc5d935ebf8bc3bc"
    "prod" = "ami-0fc5d935ebf8bc3bc"
  }
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stag" = "t2.medium"
    "prod" = "t2.large"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = lookup(var.ami,terraform.workspace,"error")
  instance_type = lookup(var.instance_type,terraform.workspace,"t2.micro")
}
