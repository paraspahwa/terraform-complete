provider "aws" {
  region = "us-east-1"
}

import {
  id = "i-00v0b0b00b0b0b0b"

  to = aws_instance.example
}

