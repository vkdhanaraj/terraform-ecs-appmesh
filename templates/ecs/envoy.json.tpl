[
	{
	    "name" : "envoy",
	    "image" : "840364872350.dkr.ecr.us-east-2.amazonaws.com/aws-appmesh-envoy:v1.12.1.0-prod",
	    "essential" : true,
	    "environment" : [
	      {
	        "name" : "APPMESH_VIRTUAL_NODE_NAME",
	        "value" : "mesh/${mesh}/virtualNode/${virtual_node}"
	      },
	      {
	          "name": "ENABLE_ENVOY_XRAY_TRACING",
	          "value": "1"
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
	},
	{
      "name": "xray-daemon",
      "image": "amazon/aws-xray-daemon",
      "cpu": 32,
      "memoryReservation": 256,
      "portMappings" : [
          {
              "containerPort": 2000,
              "protocol": "udp"
          },
          {
              "containerPort": 2000,
              "protocol": "tcp"
          }
       ]
    }   
]