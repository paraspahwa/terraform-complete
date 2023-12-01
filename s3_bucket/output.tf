output "aws_s3_bucket" {
  value = aws_s3_bucket.example.bucket
}

output "public_ip" {
  value = aws_instance.server.public_ip
}