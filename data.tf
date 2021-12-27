data "digitalocean_kubernetes_cluster" "harbor" {
  name = var.doks_cluster_name
}