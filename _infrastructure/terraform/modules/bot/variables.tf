variable "key_name" {}

variable "vpc_id" {}

variable "load_balancers" {}

variable "provider" {
  type = "map"
}

variable "security_groups" {
  type = "list"
}

variable "images" {
  description = "AWS ECS AMI id"

  default = {
    us-east-1      = "ami-cb2305a1"
    us-west-1      = "ami-bdafdbdd"
    us-west-2      = "ami-ec75908c"
    eu-west-1      = "ami-13f84d60"
    eu-central-1   = "ami-c3253caf"
    ap-northeast-1 = "ami-e9724c87"
    ap-southeast-1 = "ami-5f31fd3c"
    ap-southeast-2 = "ami-83af8ae0"
  }
}

variable "subnets" {
  type = "list"
}

variable "options" {
  type = "map"

  default = {
    hub_token             = "unknown"
    container_registry    = "hub.docker.com"
    container_name        = "unknown"
    container_image_tag   = "unknown"
    container_args        = "unknown"
    container_ports       = "unknown"
    amisize               = "unknown"
    autoscale_min         = "2"
    autoscale_max         = "5"
    autoscale_desired_cap = "2"
    tags                  = "random-bot"
    provider_alias        = "aws.dev"
  }
}

variable "azs" {
  type = "map"

  default = {
    "ap-southeast-2" = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
    "eu-west-1"      = "eu-west-1a,eu-west-1b,eu-west-1c"
    "us-west-1"      = "us-west-1b,us-west-1c"
    "us-west-2"      = "us-west-2a,us-west-2b,us-west-2c"
    "us-east-1"      = "us-east-1e,us-east-1d,us-east-1c,us-east-1b"
  }
}
