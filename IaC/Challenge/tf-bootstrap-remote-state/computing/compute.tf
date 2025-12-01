data "aws_ami" "amazon_linux" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}


resource "aws_instance" "web" {
    count         = length(local.azs)
    ami           = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type_web
    subnet_id     = element(values(aws_subnet.public).*.id, count.index)
    associate_public_ip_address = true
    key_name = var.key_pair_name != "" ? var.key_pair_name : null

    vpc_security_group_ids = [aws_security_group.web_sg.id]

    tags = {
        Name = "web-${count.index}"
        Tier = "Web"
        AZ   = element(local.azs, count.index)
    }


    user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl enable httpd
            systemctl start httpd
            echo "Hello from web-${count.index} (AZ: ${element(local.azs, count.index)})" > /var/www/html/index.html
            EOF
}

resource "aws_instance" "app" {
    count         = length(local.azs)
    ami           = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type_app
    subnet_id     = element(values(aws_subnet.private).*.id, count.index)
    associate_public_ip_address = false
    key_name = var.key_pair_name != "" ? var.key_pair_name : null

    vpc_security_group_ids = [aws_security_group.app_sg.id]

    tags = {
        Name = "app-${count.index}"
        Tier = "App"
        AZ   = element(local.azs, count.index)
    }

}
