provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {}
}

# Cloud Run has just been released as a Terraform resource, hence there isn't a module available yet.
#
# Note: It's currently not possible to create a 'public' cloud run service via Terraform. Therefore it is necessary to run
# the following command after Terraform has intially created the service:
# `gcloud beta run services update document-client --allow-unauthenticated`
# This will not need to be run for subsequent updates to the service.

resource "google_cloud_run_service" "document_client" {
  provider = "google-beta"
  project  = var.project
  location = var.location
  name     = "document-client"

  metadata {
    namespace = var.project
  }

  spec {
    containers {
      image = var.document_client_image
      env {
        name  = "BACKEND_URL"
        value = var.classify_backend_url
      }
      resources {
        limits = { "memory" = "128Mi" }
      }
    }
  }
}

# The Service is ready to be used when the "Ready" condition is True
# Due to Terraform and API limitations this is best accessed through a local variable
locals {
  cloud_run_status = {
    for cond in google_cloud_run_service.document_client.status[0].conditions :
    cond.type => cond.status
  }
}

output "isReady" {
  value = local.cloud_run_status["Ready"] == "True"
}
