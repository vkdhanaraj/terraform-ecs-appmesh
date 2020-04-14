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
  },
  {
    "name" : "envoy",
    "image" : "840364872350.dkr.ecr.us-west-2.amazonaws.com/aws-appmesh-envoy:v1.12.2.1-prod",
    "essential" : true,
    "environment" : [
      {
        "name" : "APPMESH_VIRTUAL_NODE_NAME",
        "value" : "mesh/${mesh}/virtualNode/${virtual_node}"
      }
    ],
    "healthCheck" : {
        "command" : [
              "CMD-SHELL",
              "curl -s http://localhost:9901/server_info | grep state | grep -q LIVE"
        ],
        "interval" : 5,
        "retries" : 3,
        "startPeriod" : 10,
        "timeout" : 2
      },
     "memory" : 500,
     "user" : "1337"
  }  
]
