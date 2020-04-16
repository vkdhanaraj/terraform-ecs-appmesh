[
  {
    "name": "ratings",
    "image": "${ratings_image}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${ratings_port},
        "hostPort": ${ratings_port}
      }
    ]
  }
]
