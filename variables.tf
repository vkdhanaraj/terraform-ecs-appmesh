# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-2"
}


variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "health_check_path" {
  default = "/"
}

#Productpage----------------------------------------------------------

variable "productpage_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "docker.io/istio/examples-bookinfo-productpage-v1:1.15.0"
}

variable "productpage_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 9080
}

variable "productpage_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "productpage_fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "productpage_fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}

#Details-------------------------------------------------------------------

variable "details_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "docker.io/istio/examples-bookinfo-details-v1:1.15.0"
}

variable "details_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 9080
}

variable "details_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "details_fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "details_fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}

#Ratings-------------------------------------------------------------------

variable "ratings_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "docker.io/istio/examples-bookinfo-ratings-v1:1.15.0"
}

variable "ratings_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 9080
}

variable "ratings_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "ratings_fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "ratings_fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}

#Reviews-------------------------------------------------------------------

variable "reviews_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "docker.io/istio/examples-bookinfo-reviews-v1:1.15.0"
}

variable "reviews_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 9080
}

variable "reviews_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "reviews_fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "reviews_fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}

