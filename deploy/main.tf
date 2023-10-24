terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }
  required_version = ">= 1.2"
}

provider "kubernetes" {
  config_path    = var.kubernetes_config_path
  config_context = var.kubernetes_config_context
}

provider "aws" {
  region = local.aws_region
}

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.application_name
  }
}

resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.app_namespace.metadata.0.name
    labels = {
      app = var.application_name
    }
  }
  spec {
    selector {
      match_labels = {
        app = var.application_name
      }
    }
    replicas = var.no_of_replicas
    template {
      metadata {
        labels = {
          app = var.application_name
        }
      }
      spec {
        container {
          image = "${local.aws_account}.dkr.ecr.${local.aws_region}.amazonaws.com/${local.ecr_repo}:${local.image_tag}"
          name  = var.application_name
          env {
            name  = "env"
            value = var.environment
          }
          port {
            container_port = var.application_port
          }

          resources {

          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name      = var.application_name
    namespace = kubernetes_namespace.app_namespace.metadata.0.name
  }
  spec {
    selector = {
      app = var.application_name
    }
    type = "LoadBalancer"
    port {
      port        = var.application_port
      target_port = var.application_port
    }
  }
}