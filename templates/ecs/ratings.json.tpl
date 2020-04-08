[
  {
    "name": "ratings",
    "image": "${ratings_image}",
    "cpu": ${ratings_fargate_cpu},
    "memory": ${ratings_fargate_memory},
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${ratings_port},
        "hostPort": ${ratings_port}
      }
    ]
  }
]
