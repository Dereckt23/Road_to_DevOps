resource "aws_lb" "web_alb" {
    count = var.enable_alb ? 1 : 0
    name               = "web-alb"
    internal           = false
    load_balancer_type = "application"
    subnets            = values(aws_subnet.public).*.id
    tags = { Tier = "Web" }
}

resource "aws_lb_target_group" "web_tg" {
    count = var.enable_alb ? 1 : 0
    name     = "web-tg"
    port     = var.web_port
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id
    health_check {
    path = "/"
    port = tostring(var.web_port)
    }
}

resource "aws_lb_listener" "front" {
    count = var.enable_alb ? 1 : 0
    load_balancer_arn = aws_lb.web_alb[0].arn
    port              = var.web_port
    protocol          = "HTTP"

    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg[0].arn
    }
}


resource "aws_lb_target_group_attachment" "web_attach" {
    count = var.enable_alb ? length(aws_instance.web) : 0
    target_group_arn = aws_lb_target_group.web_tg[0].arn
    target_id        = element(aws_instance.web.*.id, count.index)
    port             = var.web_port
}
