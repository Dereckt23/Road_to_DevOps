resource "aws_security_group" "web_sg" {
    name   = "web-sg-tf-challenge"
    vpc_id = aws_vpc.main.id
    description = "Allow HTTP from anywhere and allow to app tier"

    ingress {
        from_port   = var.web_port
        to_port     = var.web_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP from internet"
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH from local machine for Ansible"
}


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = { Tier = "Web" }
}


resource "aws_security_group" "app_sg" {
    name   = "app-sg-tf-challenge"
    vpc_id = aws_vpc.main.id
    description = "Only allow traffic from web servers"

    ingress {
        from_port       = 8080
        to_port         = 8080
        protocol        = "tcp"
        security_groups = [aws_security_group.web_sg.id]
        description     = "Allow from web tier"
    }

    ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
    description     = "Allow SSH from bastion"
}

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = { Tier = "App" }
}


resource "aws_security_group" "db_sg" {
    name   = "db-sg-tf-challenge"
    vpc_id = aws_vpc.main.id
    description = "DB SG - allow from app tier"

    ingress {
        from_port       = 5432
        to_port         = 5432
        protocol        = "tcp"
        security_groups = [aws_security_group.app_sg.id]
        description     = "Allow Postgres from app tier"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = { Tier = "DB" }
}
