resource "digitalocean_database_cluster" "harbor_redis" {
  #count = var.redis_deployment == "managed" ? 1 : 0

  name                 = "harbor-ext-redis"
  engine               = "redis"
  version              = "6"
  size                 = var.database_size_redis
  region               = var.region
  private_network_uuid = var.vpc_uuid
  node_count           = var.database_node_count_redis
}