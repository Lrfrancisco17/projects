resource "kubernetes_namespace" "lab" {
  metadata {
    name = var.namespace
  }
}
