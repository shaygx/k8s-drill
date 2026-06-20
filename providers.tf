terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  # This automatically uses your local ~/.kube/config
  config_path = "~/.kube/config"
}
