resource "digitalocean_database_cluster" "harbor_redis" {
  #count = var.redis_deployment == "managed" ? 1 : 0

  name                 = "harbor-redis"
  engine               = "redis"
  version              = "6"
  size                 = var.database_size_redis
  region               = data.digitalocean_kubernetes_cluster.harbor.region
  private_network_uuid = data.digitalocean_kubernetes_cluster.harbor.vpc_uuid
  node_count           = var.database_node_count_redis
}

resource "digitalocean_database_firewall" "harbor_redis" {

  count = var.firewall_databases == true ? 1 : 0

  cluster_id = var.redis_cluster_id == null ? digitalocean_database_cluster.harbor_redis.id : var.redis_cluster_id
  rule {
    type  = "k8s"
    value = data.digitalocean_kubernetes_cluster.harbor.id
  }
}