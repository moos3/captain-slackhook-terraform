// Setup core provider information
provider "aws" {
  alias      = "dev"
  region     = "${var.setup["adminregion"]}"
  profile    = "${var.setup["adminprofile"]}"
  access_key = "${var.dev_access_key}"
  secret_key = "${var.dev_secret_key}"
}

provider "aws" {
  alias      = "staging"
  region     = "${var.setup["adminregion"]}"
  profile    = "${var.setup["adminprofile"]}"
  access_key = "${var.staging_access_key}"
  secret_key = "${var.staging_secret_key}"
}

provider "aws" {
  alias      = "prod"
  region     = "${var.setup["adminregion"]}"
  profile    = "${var.setup["adminprofile"]}"
  access_key = "${var.staging_access_key}"
  secret_key = "${var.staging_secret_key}"
}

# AWS Keypair for SSH
resource "aws_key_pair" "auth" {
  provider   = "${var.aws_alias}"
  key_name   = "${var.setup["key_name"]}"
  public_key = "${file(var.setup["public_key_path"])}"
}

module "bot-vpc" {
  source     = "./_infrastructure/terraform/modules/vpc"
  vpc        = "${var.vpc}"
  app        = "${var.app}"
  env_domain = "${var.env_domain}"
  key_name   = "${var.setup["key_name"]}"
  nat        = "${var.nat}"
  provider   = "aws.dev"
}
