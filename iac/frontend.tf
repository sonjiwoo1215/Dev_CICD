variable "backend_url" {
  type = string
}

variable "container_image_fe" {
  type = string
  default = "<Your image URI here>"
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "notes-fe"
    labels = {
      App = "notes-frontend"
    }
    namespace = "prgms-notes"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "notes-frontend"
      }
    }
    template {
      metadata {
        labels = {
          App = "notes-frontend"
        }
      }
      spec {
        container {
          image = var.container_image_fe
          image_pull_policy = "Always"
          name = "notes-fe"
          port {
            container_port = 3000
          }
          env {
            name = "REACT_APP_API_BASE_URL"
            value = var.backend_url
          }
        }
        image_pull_secrets {
          name = "aws-ecr-cred"
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "notes-fe"
    namespace = "prgms-notes"
  }
  spec {
    selector = {
      App = kubernetes_deployment.frontend.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30030
      port        = 3000
      target_port = 3000
    }
    type = "NodePort"
  }
}