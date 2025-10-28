output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnets" {
    value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnets" {
    value = [for subnet in aws_subnet.private : subnet.id]
}

output "web_public_ips" {
    value = aws_instance.web[*].public_ip
}

output "web_instance_ids" {
    value = aws_instance.web[*].id
}

output "app_instance_ids" {
    value = aws_instance.app[*].id
}

output "alb_dns" {
    value = var.enable_alb ? aws_lb.web_alb[0].dns_name : ""
}
