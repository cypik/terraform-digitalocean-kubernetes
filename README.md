# terraform-digitalocean-Kubernetes 
# DigitalOcean Terraform Configuration

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This Terraform configuration is designed to create and manage a DigitalOcean Kubernetes.

## Usage
To use this module, you should have Terraform installed and configured for DIGITALOCEAN. This module provides the necessary Terraform configuration for creating DIGITALOCEAN resources, and you can customize the inputs as needed. Below is an example of how to use this module:

- # complete example
You can use this module in your Terraform configuration like this:

```hcl

module "cluster" {
  source          = "git::https://github.com/opz0/terraform-digitalocean-Kubernetes.git?ref=v1.0.0"
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
```
Please replace "your_database_cluster_id" with the actual ID of your DigitalOcean database kubernetes, and adjust the kubernetes rules as needed.


- # basic example
You can use this module in your Terraform configuration like this:
```hcl
module "cluster" {
  source          = "git::https://github.com/opz0/terraform-digitalocean-Kubernetes.git?ref=v1.0.0"
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
    }
  }

  app_node_pools = {
    app_node = {
      node_count = 1
      min_nodes  = 1
      max_nodes  = 1
      size       = "s-2vcpu-4gb"
    }
  }
}
```
This example demonstrates how to create various DIGITALOCEAN resources using the provided modules. Adjust the input values to suit your specific requirements.


## Module Inputs

- 'source': The source of the Kubernetes cluster module.
- 'name' A name for the Kubernetes cluster.
- 'environment'  The environment in which the Kubernetes cluster  rules will be applied.
- 'region' The slug identifier for the region where the Kubernetes cluster will be created.
- 'vpc_uuid' The ID of the VPC where the Kubernetes cluster will be located.

## Module Outputs

This module does not produce any outputs. It is primarily used for labeling resources within your Terraform configuration.

- 'id' A unique ID that can be used to identify and reference a Kubernetes cluster.
- 'cluster_subnet' The range of IP addresses in the overlay network of the Kubernetes cluster.
- 'service_subnet'  The range of assignable IP addresses for services running in the Kubernetes cluster.
- 'ipv4_address'  The public IPv4 address of the Kubernetes master node. This will not be set if high availability is configured on the cluster (v1.21+)
- 'endpoint'  The base URL of the API server on the Kubernetes master node.
- 'status' A string indicating the current status of the cluster. Potential values include running, provisioning, and errored.
- 'created_at' The date and time when the Kubernetes cluster was created.
- 'updated_at' The date and time when the Kubernetes cluster was last updated.
- 'auto_upgrade' A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window.
- 'kube_config' A representation of the Kubernetes cluster's kubeconfig with the following attributes:
- 'node_pool'  In addition to the arguments provided, these additional attributes about the cluster's default node pool are exported:

## Examples
For detailed examples on how to use this module, please refer to the 'examples' directory within this repository.

## License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/opz0/terraform-digitalocean-Kubernetes/blob/readme/LICENSE) file for more details.

## Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.