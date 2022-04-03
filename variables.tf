variable "auth_region" {  default = "eu-west-2" }
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "service_name" {}
variable "aws_account_id" {}
variable "auth_bucket_name" {}
variable "authr_codestar_connection" {}
variable "repo_uri" {}

locals {
  aws_region     = var.auth_region
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  # docker_run_config_sha = sha256(local_file.docker_run_config.content)
  name = "net"
  tags = { Name = "authr-app"  }
  env             = "authrrr"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.21.0/24", "10.0.31.0/24", "10.0.41.0/24"]
}

variable "cidr" {
  type    = string
  default = "145.0.0.0/16"
}

variable "azs" {
  type = list(string)
  default = [
    "eu-west-2a",
    "eu-west-2b",
  ]
}

variable "subnets-pub" {
  type = list(string)
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24",
  ]
}

variable "subnets-priv" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
}
