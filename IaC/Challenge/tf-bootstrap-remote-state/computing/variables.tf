variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "us-east-2"
}

variable "vpc_cidr" {
    description = "CIDR for the VPC"
    default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    description = "List of CIDRs for public subnets (one per AZ, in order)"
    type        = list(string)
    default     = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
    description = "List of CIDRs for private subnets (one per AZ, in order)"
    type        = list(string)
    default     = ["10.0.101.0/24","10.0.102.0/24"]
}

variable "key_pair_name" {
    description = "EC2 Key pair name"
    type        = string
    default     = "tf-challenge-key" 
}

variable "instance_type_web" {
    description = "EC2 instance type for web servers"
    type        = string
    default     = "t3.micro"
}

variable "instance_type_app" {
    description = "EC2 instance type for app servers"
    type        = string
    default     = "t3.micro"
}

variable "enable_alb" {
    description = "If true, create an ALB in front of the web servers"
    type        = bool
    default     = false
}

variable "web_port" {
    description = "Port the web tier listens on"
    type        = number
    default     = 80
}
