resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    vpc_id = var.vpc_id

    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        security_groups = [aws_security_group.container_sg.id]
    }
}

resource "aws_security_group" "container_sg" {
    name = "application"
    vpc_id = var.vpc_id

    ingress {
        description     = "SSH"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = var.pub_subnets
#        security_groups = var.pub_subnets
    }
    ingress {
        description = "API"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = var.pub_subnets

    }    
    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = var.pub_subnets

    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  vpc_id      = var.vpc_id

  ingress {
    description = "Application"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [aws_security_group.container_sg.id]
  }

  ingress {
    description     = "SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = var.pub_subnets
#    security_groups = var.pub_subnets
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}