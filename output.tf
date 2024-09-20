output "id" {
  value       = "digitalocean_kubernetes_cluster.foo.*.id"
  description = " A unique ID that can be used to identify and reference a Kubernetes cluster."
}

output "cluster_subnet" {
  value       = "digitalocean_kubernetes_cluster.foo.*.cluster_subnet"
  description = " The range of IP addresses in the overlay network of the Kubernetes cluster."
}

output "service_subnet" {
  value       = "digitalocean_kubernetes_cluster.foo.*.service_subnet"
  description = " The range of assignable IP addresses for services running in the Kubernetes cluster."
}

output "ipv4_address" {
  value       = "digitalocean_kubernetes_cluster.foo.*.ipv4_address"
  description = "The public IPv4 address of the Kubernetes master node."
}

output "endpoint" {
  value       = "digitalocean_kubernetes_cluster.foo.*.endpoint"
  description = "The base URL of the API server on the Kubernetes master node."
}

output "status" {
  value       = "digitalocean_kubernetes_cluster.foo.*.status"
  description = " A string indicating the current status of the cluster. Potential values include running, provisioning, and errored."
}

output "created_at" {
  value       = "digitalocean_kubernetes_cluster.foo.*.created_at"
  description = " The date and time when the Kubernetes cluster was created."
}

output "updated_at" {
  value       = "digitalocean_kubernetes_cluster.foo.*.updated_at"
  description = " The date and time when the Kubernetes cluster was last updated."

}

output "auto_upgrade" {
  value       = "digitalocean_kubernetes_cluster.foo.*.auto_upgrade"
  description = "A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window."
}

output "kube_config" {
  value       = "digitalocean_kubernetes_cluster.foo.*.kube_config"
  description = "A representation of the Kubernetes cluster's kubeconfig with the following attributes:"
}

output "node_pool" {
  value       = "digitalocean_kubernetes_cluster.foo.*.node_pool"
  description = "In addition to the arguments provided, these additional attributes about the cluster's default node pool are exported:"

}

output "raw_config" {
  value       = "digitalocean_kubernetes_cluster.foo.*.raw_config"
  description = "The full contents of the Kubernetes cluster's kubeconfig file."
}

output "host" {
  value       = "digitalocean_kubernetes_cluster.foo.*.host"
  description = "The URL of the API server on the Kubernetes master node."
}

output "cluster_ca_certificate" {
  value       = "digitalocean_kubernetes_cluster.foo.*.cluster_ca_certificate"
  description = "The base64 encoded public certificate for the cluster's certificate authority."
}