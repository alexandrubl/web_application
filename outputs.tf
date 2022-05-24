output "alb_dns" {
  description = "alb dns"
  value       = module.application.dns_name
}

#output "bastion_public_ip" {
#  description = "Bastion public ip"
#  value       = module.bastion.bastion_public_ip
#}

#output "application_private_ips" {
#  description = "Application instance private ips"
#  value       = module.application.instance_private_ips
#}

#output "database_private_ip" {
#  description = "Database private ip"
#  value       = module.storage.db_private_ip
#}