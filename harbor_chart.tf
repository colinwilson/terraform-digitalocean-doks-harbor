resource "helm_release" "harbor" {
  name       = "harbor-v${replace(var.harbor_chart_version, ".", "-")}"
  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  version    = var.harbor_chart_version

  values = [templatefile("${path.module}/harbor_chart_values.yaml", {

    # Harbor chart custom values
    harbor_ext_url = var.harbor_ext_url

    # DigitalOcean Spaces access parameter
    do_spaces_access_key  = var.do_spaces_access_key
    do_spaces_secret_key  = var.do_spaces_secret_key
    do_spaces_endpoint    = local.do_spaces_endpoint # var.do_spaces_endpoint
    do_spaces_bucket_name = digitalocean_spaces_bucket.harbor.name

    # DigitalOcean Postgres connection parameters
    pg_cluster_host     = var.pg_cluster_host == null ? digitalocean_database_cluster.harbor.private_host : var.pg_cluster_host
    pg_cluster_port     = var.pg_cluster_port == null ? digitalocean_database_cluster.harbor.port : var.pg_cluster_port
    pg_cluster_username = var.database_user_pg
    pg_cluster_password = var.pg_cluster_password == null ? digitalocean_database_user.harbor.password : var.pg_cluster_password

    # DigitalOcean Redis connection parameters
    # redis_addr = var.redis_deployment == "managed" ? "redis-proxy:6379" : "${helm_release.redis.name}-master:6379" #"${digitalocean_database_cluster.harbor_redis.private_host}:${digitalocean_database_cluster.harbor_redis.port}"
    redis_addr     = "redis-proxy:6379" # "${helm_release.redis.name}-master:6379" #"${digitalocean_database_cluster.harbor_redis.private_host}:${digitalocean_database_cluster.harbor_redis.port}"
    redis_password = var.redis_password == null ? digitalocean_database_cluster.harbor_redis.password : var.redis_password
  })]
}