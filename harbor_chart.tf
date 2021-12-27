resource "helm_release" "harbor" {
  name       = "harbor-v${replace(var.harbor_chart_version, ".", "-")}"
  namespace  = kubernetes_namespace.harbor.metadata.0.name
  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  version    = var.harbor_chart_version

  values = [templatefile("${path.module}/harbor_chart_values.yaml", {

    # Harbor chart custom values
    harbor_cert_cn        = var.harbor_cert_cn
    harbor_ext_url        = var.harbor_ext_url
    harbor_admin_password = var.harbor_admin_password

    # DigitalOcean Spaces access parameter
    spaces_access_id   = var.spaces_access_id
    spaces_secret_key  = var.spaces_secret_key
    spaces_endpoint    = local.spaces_endpoint
    spaces_bucket_name = digitalocean_spaces_bucket.harbor.name

    # DigitalOcean Postgres connection parameters
    pg_cluster_host     = var.pg_cluster_host == null ? digitalocean_database_cluster.harbor_postgres.private_host : var.pg_cluster_host
    pg_cluster_port     = var.pg_cluster_port == null ? digitalocean_database_cluster.harbor_postgres.port : var.pg_cluster_port
    pg_cluster_username = var.database_user_pg
    pg_cluster_password = var.pg_cluster_password == null ? digitalocean_database_user.harbor.password : var.pg_cluster_password

    # DigitalOcean Redis connection parameters
    # redis_addr = var.redis_deployment == "managed" ? "redis-proxy:6379" : "${helm_release.redis.name}-master:6379" #"${digitalocean_database_cluster.harbor_redis.private_host}:${digitalocean_database_cluster.harbor_redis.port}"
    redis_addr     = "redis-proxy:6379" # "${helm_release.redis.name}-master:6379" #"${digitalocean_database_cluster.harbor_redis.private_host}:${digitalocean_database_cluster.harbor_redis.port}"
    redis_password = var.redis_password == null ? digitalocean_database_cluster.harbor_redis.password : var.redis_password
    # redis_addr = "${helm_release.redis.name}-master:6379"
  })]
}