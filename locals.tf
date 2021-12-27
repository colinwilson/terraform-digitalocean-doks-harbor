locals {

  spaces_region   = length(regexall("^nyc3|ams3|fra1|sgp1|sfo3$", data.digitalocean_kubernetes_cluster.harbor.region)) > 0 ? data.digitalocean_kubernetes_cluster.harbor.region : "fra1"
  spaces_endpoint = "https://${local.spaces_region}.digitaloceanspaces.com"
}