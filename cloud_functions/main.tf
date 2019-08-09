provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {}
}

module "classify" {
  source = "github.com/fuzzylabs/terraform-google-cloud-function?ref=initial_branch"

  project_id            = var.project
  region                = var.location
  name                  = "classify"
  runtime               = "python37"
  source_archive_bucket = "${var.billing_org_id}_${var.customer}_${var.project_group}_${var.env}_cloud-functions"
  source_archive_object = var.classify_zipfile
  entry_point           = "classify"
  roles = [
    "roles/viewer",
  ]
}
