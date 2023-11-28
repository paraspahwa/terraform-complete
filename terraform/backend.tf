terraform {
  backend "s3" {
    bucket = "paras-bucket-xyz"
    region = "us-east-1"
    key = "paras/terraform.tfstate"
    encrypt = true
    dynamodb_table = "terraform-lock"
  }
}