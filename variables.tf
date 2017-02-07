variable "setup" {
  type = "map"

  default = {
    key_name        = "slackhook-key"
    public_key_path = "~/.ssh/id_rsa.pub"
    adminprofile    = "default"
    adminregion     = "us-east-1"
    instance_type   = "t1.micro"
  }
}

variable "elb_slackhook_options" {
  type = "map"

  default = {
    tag                = "unknown"
    app_name           = "slackhook-api"
    subnets            = "unknown"
    elb_security_group = "unknown"
    listen_port_http   = 80
    listen_protocol    = "http"
    lb_port            = 80
    lb_protocol        = "http"
    hc_protocol        = "http"
    elb_hc_uri         = "/"
    provider_alias     = "aws.dev"
  }
}

variable "elb_thegeneral_options" {
  type = "map"

  default = {
    tag                = "unknown"
    app_name           = "thegeneral-api"
    subnets            = "unknown"
    elb_security_group = "unknown"
    listen_port_http   = 80
    listen_protocol    = "http"
    lb_port            = 80
    lb_protocol        = "http"
    hc_protocol        = "http"
    elb_hc_uri         = "/"
    provider_alias     = "aws.dev"
  }
}

variable "slackhook" {
  type = "map"

  default = {
    hub_token             = "unknown"
    registry              = "hub.docker.com"
    loggly_token          = "unknown"
    auth_webhook_secret   = "unknown"
    hipchat_token         = "unknown"
    slack_token           = "unknown"
    amisize               = "unknown"
    autoscale_min         = "2"
    autoscale_max         = "5"
    autoscale_desired_cap = "2"
    tag                   = "slackhook"
    account               = "aws.unknown"
    region                = "us-east-1"
    provider_alias        = "aws.dev"
  }
}

variable "thegeneral" {
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

variable "vpc" {
  type = "map"

  default = {
    "tag"         = "unknown"
    "cidr_block"  = "unknown"
    "subnet_bits" = "unknown"
    "owner_id"    = "unknown"
    "sns_topic"   = "unknown"
    "region"      = "us-east-1"
  }
}

variable "azs" {
  type = "map"

  default = {
    "ap-southeast-2" = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
    "eu-west-1"      = "eu-west-1a,eu-west-1b,eu-west-1c"
    "us-west-1"      = "us-west-1b,us-west-1c"
    "us-west-2"      = "us-west-2a,us-west-2b,us-west-2c"
    "us-east-1"      = "us-east-1c,us-west-1d,us-west-1e"
  }
}

variable "nat" {
  type = "map"

  default = {
    ami_image         = "unknown"
    instance_type     = "unknown"
    availability_zone = "unknown"
    key_name          = "unknown"
    filename          = "userdata_nat_asg.sh"
  }
}

/* Ubuntu Trusty 14.04 LTS (x64) */
variable "images" {
  type = "map"

  default = {
    eu-west-1      = "ami-47a23a30"
    ap-southeast-2 = "ami-6c14310f"
    us-east-1      = "ami-2d39803a"
    us-west-1      = "ami-48db9d28"
    us-west-2      = "ami-d732f0b7"
  }
}

variable "env_domain" {
  type = "map"

  default = {
    name    = "unknown"
    zone_id = "unknown"
  }
}

variable "app" {
  default = {
    elb_ssl_cert_arn  = ""
    elb_hc_uri        = ""
    listen_port_http  = ""
    listen_port_https = ""
    domain_account    = ""
  }
}

variable "staging_secret_key" {}
variable "staging_access_key" {}

variable "dev_secret_key" {}
variable "dev_access_key" {}

variable "prod_secret_key" {}
variable "prod_access_key" {}
