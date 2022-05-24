output "dns_name" {
  description = "alb dns"
  value       = aws_lb.alb.dns_name
}

#output "instance_private_ips" {
#  description = "Instance private ips"
#  value       = data.aws_instances.webserver.private_ips
#}