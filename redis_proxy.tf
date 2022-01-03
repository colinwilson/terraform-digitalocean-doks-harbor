# 2021-12-15: Harbor doesn't currently support secure (TLS) connections to Redis
# hence this k8s service and socat daemonset to proxy the connection to DO's managed Redis

resource "kubernetes_service" "redis_proxy" {
  metadata {
    name      = "redis-proxy"
    namespace = local.namespace
    labels = {
      app = "redis-proxy"
    }
  }
  spec {
    selector = {
      app = kubernetes_daemonset.redis_proxy.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 6379
      target_port = 6379
    }
  }
}

resource "kubernetes_daemonset" "redis_proxy" {
  metadata {
    name      = "redis-proxy"
    namespace = local.namespace
    labels = {
      app = "redis-proxy"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "redis-proxy"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis-proxy"
        }
      }

      spec {
        container {
          image = "aigis/socat:1.7.4.2-r0"
          name  = "redis-proxy"

          args = [
            "-v",
            "-d",
            "-d",
            "TCP-LISTEN:6379,fork,reuseaddr",
            "openssl:${local.redis_cluster_host}:${local.redis_cluster_port}",
          ]

          port {
            name           = "redis"
            container_port = 6379
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "100Mi"
            }
            requests = {
              cpu    = "50m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}