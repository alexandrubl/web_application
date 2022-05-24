output "container_sg_id" {
  description = "container sg"
  value       = aws_security_group.container_sg.id
}

output "alb_sg_id" {
  description = "alb sg"
  value       = aws_security_group.alb_sg.id
}

#output "database_sg_id" {
#  description = "database sg"
#  value       = aws_security_group.database_sg.id
#}

output "bastion_sg_id" {
  description = "bastion sg"
  value       = aws_security_group.bastion_sg.id
}