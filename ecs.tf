resource "aws_ecs_cluster" "ecs" {
  name = var.name

  capacity_providers = compact([
    try(aws_ecs_capacity_provider.ecs_capacity_provider[0].name, ""),
    "FARGATE",
    "FARGATE_SPOT"
  ])

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

    dynamic "setting" {
      for_each = var.enable_container_insight ? ["1"]: []
      content {
          name  = "containerInsights"
          value = "enabled"
      }
    }
  

}
