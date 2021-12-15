resource "kubernetes_namespace" "harbor" {
  metadata {
    name = "harbor"
  }
}