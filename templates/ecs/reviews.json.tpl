[
  {
    "name": "reviews",
    "image": "${reviews_image}",
    "cpu": ${reviews_fargate_cpu},
    "memory": ${reviews_fargate_memory},
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${reviews_port},
        "hostPort": ${reviews_port}
      }],
    "environment": [
        {
          "name": "RATINGS_HOSTNAME",
          "value": "ratings.mydomain"
        }    
    ]
  }
]
