resource "aws_ecs_cluster" "ecs-cluster" {
  name                 = "${var.ecs_name}-cluster"

  tags = {
    Name = "${var.ecs_name}_cluster"
  }
}