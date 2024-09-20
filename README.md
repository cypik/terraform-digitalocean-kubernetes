# Terraform-digitalocean-Kubernetes
# Terraform digitalocean Cloud Kubernetes Module.


## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#examples)
- [Author](#author)
- [License](#license)
- [Inputs](#inputs)
- [Outputs](#outputs)
## Introduction
This Terraform configuration is designed to create and manage a DigitalOcean Kubernetes.

## Usage
To use this module, you should have Terraform installed and configured for DIGITALOCEAN. This module provides the necessary Terraform configuration for creating DIGITALOCEAN resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Example: Complete
You can use this module in your Terraform configuration like this:
```hcl

module "cluster" {
  source          = "cypik/kubernetes/digitalocean"
  version         = "1.0.2"
  name            = local.name
  environment     = local.environment
  region          = local.region
  cluster_version = "1.31.1-do.0"
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


# Example: Basic
You can use this module in your Terraform configuration like this:
```hcl
module "cluster" {
  source          = "cypik/kubernetes/digitalocean"
  version         = "1.0.1"
  name            = local.name
  environment     = local.environment
  region          = local.region
  cluster_version = "1.31.1-do.0"
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

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/cypik/terraform-digitalocean-kubernetes/tree/master/example) directory within this repository.

## Author
Your Name Replace **MIT** and **Cypik** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This Terraform module is provided under the **MIT** License. Please see the [LICENSE](https://github.com/cypik/terraform-digitalocean-Kubernetes/blob/master/LICENSE) file for more details.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.5 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | cypik/labels/digitalocean | 1.0.2 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.main](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_kubernetes_node_pool.main](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_node_pools"></a> [app\_node\_pools](#input\_app\_node\_pools) | Cluster additional node pools. | `map(any)` | `{}` | no |
| <a name="input_auto_upgrade"></a> [auto\_upgrade](#input\_auto\_upgrade) | Enable auto upgrade during maintenance window. | `bool` | `false` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | K8s Cluster Version. | `string` | `"1.31.1-do.0"` | no |
| <a name="input_critical_node_pool"></a> [critical\_node\_pool](#input\_critical\_node\_pool) | Cluster default node pool. | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create the resources. Set to `false` to prevent the module from creating any resources. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_ha"></a> [ha](#input\_ha) | Enable high availability control plane. | `bool` | `true` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `cypik`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_maintenance_policy"></a> [maintenance\_policy](#input\_maintenance\_policy) | Define the window updates are to be applied when auto upgrade is set to true. | <pre>object({<br>    day        = string<br>    start_time = string<br>  })</pre> | <pre>{<br>  "day": "any",<br>  "start_time": "5:00"<br>}</pre> | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy,  cypik | `string` | `"cypik"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | K8s Cluster Region. | `string` | `"blr1"` | no |
| <a name="input_registry_integration"></a> [registry\_integration](#input\_registry\_integration) | Enables or disables the DigitalOcean container registry integration for the cluster. This requires that a container registry has first been created for the account. | `bool` | `false` | no |
| <a name="input_surge_upgrade"></a> [surge\_upgrade](#input\_surge\_upgrade) | Enable surge upgrade during maintenance window. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags to apply to the cluster. | `list(string)` | `[]` | no |
| <a name="input_vpc_uuid"></a> [vpc\_uuid](#input\_vpc\_uuid) | The ID of the VPC where the Kubernetes cluster will be located. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auto_upgrade"></a> [auto\_upgrade](#output\_auto\_upgrade) | A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window. |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | The base64 encoded public certificate for the cluster's certificate authority. |
| <a name="output_cluster_subnet"></a> [cluster\_subnet](#output\_cluster\_subnet) | The range of IP addresses in the overlay network of the Kubernetes cluster. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The date and time when the Kubernetes cluster was created. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The base URL of the API server on the Kubernetes master node. |
| <a name="output_host"></a> [host](#output\_host) | The URL of the API server on the Kubernetes master node. |
| <a name="output_id"></a> [id](#output\_id) | A unique ID that can be used to identify and reference a Kubernetes cluster. |
| <a name="output_ipv4_address"></a> [ipv4\_address](#output\_ipv4\_address) | The public IPv4 address of the Kubernetes master node. |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | A representation of the Kubernetes cluster's kubeconfig with the following attributes: |
| <a name="output_node_pool"></a> [node\_pool](#output\_node\_pool) | In addition to the arguments provided, these additional attributes about the cluster's default node pool are exported: |
| <a name="output_raw_config"></a> [raw\_config](#output\_raw\_config) | The full contents of the Kubernetes cluster's kubeconfig file. |
| <a name="output_service_subnet"></a> [service\_subnet](#output\_service\_subnet) | The range of assignable IP addresses for services running in the Kubernetes cluster. |
| <a name="output_status"></a> [status](#output\_status) | A string indicating the current status of the cluster. Potential values include running, provisioning, and errored. |
| <a name="output_updated_at"></a> [updated\_at](#output\_updated\_at) | The date and time when the Kubernetes cluster was last updated. |
<!-- END_TF_DOCS -->