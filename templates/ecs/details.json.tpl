[
  {
    "name": "details",
    "image": "${details_image}",
    "cpu": ${details_fargate_cpu},
    "memory": ${details_fargate_memory},
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${details_port},
        "hostPort": ${details_port}
      }
    ]
  }
]
