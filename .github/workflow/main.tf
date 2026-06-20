resource "kubernetes_namespace" "demo_namespace" {
  metadata {
    name = "production"
  }
}

resource "kubernetes_deployment" "demo_app" {
  metadata {
    name      = "demo-app"
    namespace = kubernetes_namespace.demo_namespace.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = { app = "demo-app" }
    }
    template {
      metadata {
        labels = { app = "demo-app" }
      }
      spec {
        container {
          image = "nginx:alpine" # Placeholder until we build your image
          name  = "demo-app"
        }
      }
    }
  }
}


# Testing the Pipeline
