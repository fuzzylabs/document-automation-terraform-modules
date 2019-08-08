provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {}
}

module "circleci" {
  source   = "github.com/fuzzylabs/terraform-google-service-account?ref=master"
  location = var.location
  project  = var.project
  name     = "circleci"
  roles = [
    "roles/viewer",
    "roles/storage.objectAdmin",
    "roles/cloudfunctions.developer",
    "roles/iam.serviceAccountUser"
  ]
}
