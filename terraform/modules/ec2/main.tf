


# EC2 instnce for nginx
resource "aws_instance" "nginx" {
  ami               = var.ami_ubuntu
  instance_type     = var.instance_type
  subnet_id         = var.private_subnet_id
  user_data = file("${path.module}/init_instance.sh")
  key_name          = var.key_pair_name
  security_groups   = [var.nginx_sg_id]
  associate_public_ip_address = false
  tags = {
    Name = "nginxEC2"
    Owner = var.owner
  }

}

# bastion option
resource "aws_instance" "bastion" {
  ami               = var.ami_ubuntu
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_id[0]
  key_name          = var.key_pair_name
  security_groups   = [var.bastion_sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "bastionEC2"
    Owner = var.owner
  }

}

# ELB

# elb itself
resource "aws_lb" "nginx_lb" {
    name               = "nginx-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [var.elb_sg_id]
    subnets            = var.public_subnet_id
    enable_deletion_protection = false

    enable_cross_zone_load_balancing = true

    tags = {
        Name = "nginx-lb"
        Owner = var.owner
    }
}

# tg for the elb
resource "aws_lb_target_group" "nginx_target_group" {
    name     = "nginx-target-group"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id

  health_check {
    interval            = 30  # how long does the HC will be
    path                = "/" # the path that the elb req
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5 # how long will it wait for responsed
    unhealthy_threshold = 2 # how much untill unhealty condition
    healthy_threshold   = 2 # how much untill healty condition
  }

  tags = {
    Name = "nginx-target-group"
  }
}

# listener for the elb
resource "aws_lb_listener" "nginx_listener" {
    load_balancer_arn = aws_lb.nginx_lb.arn
    port              = "80"
    protocol          = "HTTP"


    # when a req comes to the lb. itll be forward to the tg
    default_action {
        target_group_arn = aws_lb_target_group.nginx_target_group.arn
        type             = "forward"
    }
}

# attach ec2 to the tg
resource "aws_lb_target_group_attachment" "nginx_target_attachment" {
    target_group_arn = aws_lb_target_group.nginx_target_group.arn
    target_id        = aws_instance.nginx.id
    port             = 80
}
