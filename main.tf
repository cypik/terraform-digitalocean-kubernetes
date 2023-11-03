module "labels" {
  source      = "git::https://github.com/opz0/terraform-digitalocean-labels.git?ref=v1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

resource "digitalocean_kubernetes_cluster" "main" {
  count                = var.enabled ? 1 : 0
  name                 = format("%s-cluster-511", tostring(var.surge_upgrade))
  region               = var.region
  version              = var.cluster_version
  vpc_uuid             = var.vpc_uuid
  auto_upgrade         = var.auto_upgrade
  surge_upgrade        = var.surge_upgrade
  ha                   = var.ha
  registry_integration = var.registry_integration

  dynamic "node_pool" {
    for_each = var.critical_node_pool
    content {
      name       = lookup(node_pool.value, "name", "critical")
      size       = lookup(node_pool.value, "size", "s-1vcpu-2gb")
      node_count = lookup(node_pool.value, "node_count", 1)
      auto_scale = lookup(node_pool.value, "auto_scale", true)
      min_nodes  = lookup(node_pool.value, "min_nodes", 1)
      max_nodes  = lookup(node_pool.value, "max_nodes", 1)
      tags       = lookup(node_pool.value, "tags", null)
      labels     = lookup(node_pool.value, "labels", null)
      dynamic "taint" {
        for_each = lookup(node_pool.value, "taint", [])
        content {
          key    = lookup(taint.value, "key", null)
          value  = lookup(taint.value, "value", null)
          effect = lookup(taint.value, "effect", null)
        }
      }
    }
  }

  dynamic "maintenance_policy" {
    for_each = var.auto_upgrade ? [1] : []
    content {
      day        = var.maintenance_policy.day
      start_time = var.maintenance_policy.start_time
    }
  }
  tags = var.tags
}

resource "digitalocean_kubernetes_node_pool" "main" {
  for_each   = var.enabled ? var.app_node_pools : {}
  cluster_id = join("", digitalocean_kubernetes_cluster.main[*].id)
  name       = lookup(each.value, "name", "application")
  size       = lookup(each.value, "size", "s-1vcpu-2gb")
  node_count = lookup(each.value, "node_count", 1)
  auto_scale = lookup(each.value, "auto_scale", true)
  min_nodes  = lookup(each.value, "min_nodes", 1)
  max_nodes  = lookup(each.value, "max_nodes", 1)
  tags       = lookup(each.value, "tags", null)
  labels     = lookup(each.value, "labels", null)

  dynamic "taint" {
    for_each = lookup(each.value, "taint", [])
    content {
      key    = taint.value["key"]
      value  = taint.value["value"]
      effect = taint.value["effect"]
    }
  }
}