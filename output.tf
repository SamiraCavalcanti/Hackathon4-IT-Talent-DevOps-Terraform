output "instance_ip" {
  description = "Endereco IP publico da minha instancia"
  value       = aws_instance.example.public_ip
}
