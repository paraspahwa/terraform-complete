output "public_ip" {
  description = "public_ip of an instance"
  value = aws_instance.example.public_ip
}