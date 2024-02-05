provider "digitalocean" {

}

locals {
  name        = "app"
  environment = "test"
  region      = "nyc3"
}

##------------------------------------------------
## VPC module call
##------------------------------------------------
module "vpc" {
  source      = "cypik/vpc/digitalocean"
  version     = "1.0.1"
  name        = "digitalocen-vpc-2"
  environment = local.environment
  region      = local.region
  ip_range    = "10.24.0.0/16"
}

##------------------------------------------------
## Kubernetes module call
##------------------------------------------------
module "cluster" {
  source          = "./../../"
  name            = local.name
  environment     = local.environment
  region          = local.region
  cluster_version = "1.27.6-do.0"
  vpc_uuid        = module.vpc.id

  critical_node_pool = {
    critical_node = {
      node_count = 1
      min_nodes  = 1
      max_nodes  = 1
      size       = "s-2vcpu-4gb"
      labels     = { "cluster" = "critical", }
      tags       = ["demo"]
      taint = [
        {
          key    = "name"
          value  = "default"
          effect = "NoSchedule"
        }
      ]
    }
  }

  app_node_pools = {
    app_node = {
      size       = "s-2vcpu-4gb"
      node_count = 1
      min_nodes  = 1
      max_nodes  = 1
      labels     = { "cluster" = "application" }
      tags       = ["demo"]
      taint = [
        {
          key    = "mysize"
          value  = "large"
          effect = "NoSchedule"
        }
      ]
    }
  }
}
