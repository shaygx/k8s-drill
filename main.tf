resource "kubernetes_namespace" "demo_namespace" {
  metadata {
    name = "production"
  }
}

resource "kubernetes_deployment" "demo_app" {
  metadata {
    name      = "demo-app"
    namespace = "production"
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
          # Replace with your actual image path later
          image = "nginx:alpine" 
          name  = "demo-app"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "demo_service" {
  metadata {
    name      = "demo-service"
    namespace = kubernetes_namespace.demo_namespace.metadata[0].name
  }
  spec {
    selector = { app = "demo-app" }
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_ingress_v1" "demo_ingress" {
  metadata {
    name      = "demo-ingress"
    namespace = "production"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "demoapp.local"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "demo-service"
              port { number = 80 }
            }
          }
        }
      }
    }
  }
}
