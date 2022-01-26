resource "helm_release" "redis-proxy" {
  name             = "redis-proxy"
  namespace        = var.harbor_namespace
  create_namespace = true
  repository       = "https://charts.aigis.io"
  chart            = "redis-proxy"
  version          = "0.1.3"

  # If values file specified by the var.values_file input variable exists then apply the values from this file
  # else apply the default values from the chart
  values = [fileexists("${path.root}/${var.values_file}") == true ? file("${path.root}/${var.values_file}") : ""]

  set {
    name  = "destination.address.host"
    value = local.redis_cluster_host
  }

  set {
    name  = "destination.address.port"
    value = local.redis_cluster_port
  }

  set {
    name  = "sessionAffinity"
    value = "ClientIP"
  }

}