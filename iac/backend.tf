variable "db_host" {
  type = string
}

variable "db_port" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_passwd" {
  type = string
}

variable "db_name" {
  type = string
}

variable "frontend_url" {
  type = string
}

variable "container_image_be" {
  type = string
  default = "<Your image URI here>"
}

resource "kubernetes_config_map" "backend-config" {
  metadata {
    name = "notes-be-config"
    namespace = "prgms-notes"
  }
  data = {
    DB_HOST = var.db_host
    DB_PORT = var.db_port
    DB_USER = var.db_user
    DB_PASSWD = var.db_passwd
    DB_NAME = var.db_name
    CORS_ALLOWED_ORIGIN = var.frontend_url
  }
}

resource "kubernetes_deployment" "backend" {
  metadata {
    name = "notes-be"
    labels = {
      App = "notes-backend"
    }
    namespace = "prgms-notes"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "notes-backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "notes-backend"
        }
      }
      spec {
        container {
          image = var.container_image_be
          image_pull_policy = "Always"
          name = "notes-be"
          env_from {
            config_map_ref {
              name = "notes-be-config"
            }
          }
        }
        image_pull_secrets {
          name = "aws-ecr-cred"
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  metadata {
    name = "notes-be"
    namespace = "prgms-notes"
  }
  spec {
    selector = {
      App = kubernetes_deployment.backend.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30031
      port        = 3031
      target_port = 3031
    }
    type = "NodePort"
  }
}
