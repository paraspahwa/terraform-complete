variable "instance_type" {
  description   = "instance_type value"
  default       = "t2.micro"
  type          = string
}

variable "key_pair" {
  description = "key_pair value"
  type = string
}

variable "ami_id" {
  description = "ami_id value"
  type = string
}

variable "cidr" {
  default = "10.0.0.0/16"
}

