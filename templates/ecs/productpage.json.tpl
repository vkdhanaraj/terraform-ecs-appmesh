[
  {
    "name": "productpage",
    "image": "${productpage_image}",
    "cpu": ${productpage_fargate_cpu},
    "memory": ${productpage_fargate_memory},
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${productpage_port},
        "hostPort": ${productpage_port}
      }
    ],
    "environment": [
        {
          "name": "DETAILS_HOSTNAME",
          "value": "details.mydomain"
        },
        {
          "name": "RATINGS_HOSTNAME",
          "value": "ratings.mydomain"
        },
        {
          "name": "REVIEWS_HOSTNAME",
          "value": "reviews.mydomain"
        }
    ]
  }
]
