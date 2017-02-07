### Provider
setup = {
  type = "map"

  default = {
    key_name        = "slackhook-key"
    public_key_path = "~/.ssh/id_rsa.pub"
    adminprofile    = "default"
    adminregion     = "us-east-1"
    instance_type   = "t1.micro"
  }
}

subnets = []

slackhook = {
  hub_token             = "unknown"
  slack_token           = "unknown"
  hipchat_token         = "unknown"
  auth_webhook_secret   = "unknown"
  loggly_token          = "unknown"
  ecs_task_family       = "slackhook-api-2"
  ecs_cluster_name      = "bot-world2"
  ecs_auth_type         = "dockercfg"
  registry              = "registry.example.com"
  amisize               = "t2.small"
  autoscale_min         = "2"
  autoscale_max         = "5"
  autoscale_desired_cap = "2"
  tag                   = "bots"
  account               = "aws.dev"
  project_name          = "slackhook"
  region                = "us-east-1"
  container_name        = "captain-slackhook"
  container_image_tag   = "latest"
  container_registry    = "registry.example.com/containers"
  env_tag               = "staging"
  provider_alias        = "aws.dev"
}

thegeneral = {
  hub_token             = "unknown"
  slack_token           = "unknown"
  hipchat_token         = "unknown"
  auth_webhook_secret   = "unknown"
  loggly_token          = "unknown"
  ecs_task_family       = "slackhook-api-2"
  ecs_cluster_name      = "bot-world2"
  ecs_auth_type         = "dockercfg"
  registry              = "registry.example.com"
  amisize               = "t2.small"
  autoscale_min         = "2"
  autoscale_max         = "5"
  autoscale_desired_cap = "2"
  tag                   = "bots"
  account               = "aws.dev"
  project_name          = "thegeneral"
  region                = "us-east-1"
  env_tag               = "staging"
  provider_alias        = "aws.dev"
}

vpc = {
  tag = "moose-TEST"

  // aws account id
  owner_id       = "unknown"
  cidr_block     = "10.0.0.0/20"
  subnet_bits    = "4"
  sns_email      = "richard@example.com"
  account        = "dev"
  provider_alias = "aws.dev"
}

nat = {
  instance_type = "m3.medium"
  filename      = "userdata_nat_asg.sh"
}

env_domain = {
  name    = "exampledev.com"
  zone_id = "unknown"
}

app = {
  instance_type     = "t2.small"
  host_name         = "slackhook"
  elb_ssl_cert_arn  = ""
  elb_hc_uri        = "/"
  listen_port_http  = "80"
  listen_port_https = "443"
  domain            = "example-bots.xyz"
  zone_id           = "unknown"
  name              = "slackhook"
  domain_account    = "dev"
}
