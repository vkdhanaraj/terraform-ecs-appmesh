# ecs.tf

resource "aws_ecs_cluster" "main" {
  name = "test"
}

resource "aws_service_discovery_private_dns_namespace" "mydomain" {
  name        = "mydomain"
  vpc         = "${aws_vpc.main.id}"
}

#Productpage-------------------------------------------------------

data "template_file" "productpage" {
  template = file("./terraform/templates/ecs/productpage.json.tpl")

  vars = {
    productpage_image      = var.productpage_image
    productpage_port       = var.productpage_port
    productpage_fargate_cpu    = var.productpage_fargate_cpu
    productpage_fargate_memory = var.productpage_fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "productpage" {
  family = "productpage"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.productpage_fargate_cpu
  memory                   = var.productpage_fargate_memory
  container_definitions    = data.template_file.productpage.rendered
}

resource "aws_ecs_service" "productpage" {
  name            = "productpage"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.productpage.arn
  desired_count   = var.productpage_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "productpage"
    container_port   = var.productpage_port
  }

  service_registries{
    registry_arn = aws_service_discovery_service.productpage.arn
    port = 9080
  }


  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]

}
  resource "aws_service_discovery_service" "productpage" {
  name = "productpage"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.mydomain.id}"

    dns_records {
      ttl  = 60
      type = "A"
    }

    dns_records {
      ttl  = 60
      type = "SRV"
    }
  }

  }

#Details------------------------------------------------------

data "template_file" "details" {
  template = file("./terraform/templates/ecs/details.json.tpl")

  vars = {
    details_image      = var.details_image
    details_port       = var.details_port
    details_fargate_cpu    = var.details_fargate_cpu
    details_fargate_memory = var.details_fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "details" {
  family = "details-t"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.details_fargate_cpu
  memory                   = var.details_fargate_memory
  container_definitions    = data.template_file.details.rendered
}

resource "aws_ecs_service" "details" {
  name            = "details"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.details.arn
  desired_count   = var.details_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  service_registries{
    registry_arn = aws_service_discovery_service.details.arn
    port = 9080
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role]
}

  resource "aws_service_discovery_service" "details" {
  name = "details"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.mydomain.id}"

    dns_records {
      ttl  = 60
      type = "A"
    }

    dns_records {
      ttl  = 60
      type = "SRV"
    }
  }

  }

#Ratings------------------------------------------------------------------

data "template_file" "ratings" {
  template = file("./terraform/templates/ecs/ratings.json.tpl")

  vars = {
    ratings_image      = var.ratings_image
    ratings_port       = var.ratings_port
    ratings_fargate_cpu    = var.ratings_fargate_cpu
    ratings_fargate_memory = var.ratings_fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "ratings" {
  family = "ratings-t"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ratings_fargate_cpu
  memory                   = var.ratings_fargate_memory
  container_definitions    = data.template_file.ratings.rendered
}

resource "aws_ecs_service" "ratings" {
  name            = "ratings"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.ratings.arn
  desired_count   = var.ratings_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  service_registries{
    registry_arn = aws_service_discovery_service.ratings.arn
    port = 9080
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role]
}

  resource "aws_service_discovery_service" "ratings" {
  name = "ratings"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.mydomain.id}"

    dns_records {
      ttl  = 60
      type = "A"
    }

    dns_records {
      ttl  = 60
      type = "SRV"
    }
  }

  }

#Reviews------------------------------------------------------------------

data "template_file" "reviews" {
  template = file("./terraform/templates/ecs/reviews.json.tpl")

  vars = {
    reviews_image      = var.reviews_image
    reviews_port       = var.reviews_port
    reviews_fargate_cpu    = var.reviews_fargate_cpu
    reviews_fargate_memory = var.reviews_fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "reviews" {
  family = "reviews-t"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.reviews_fargate_cpu
  memory                   = var.reviews_fargate_memory
  container_definitions    = data.template_file.reviews.rendered
}

resource "aws_ecs_service" "reviews" {
  name            = "reviews"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.reviews.arn
  desired_count   = var.reviews_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  service_registries{
    registry_arn = aws_service_discovery_service.reviews.arn
    port = 9080
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role]
}

  resource "aws_service_discovery_service" "reviews" {
  name = "reviews"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.mydomain.id}"

    dns_records {
      ttl  = 60
      type = "A"
    }

    dns_records {
      ttl  = 60
      type = "SRV"
    }
  }

  }

