provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {}
}

module "classify" {
  source  = "github.com/fuzzylabs/terraform-google-service-account?ref=initial_commit"

  project = var.project
  name    = "classify"
  runtime = "python37"
  source_archive_bucket = "${var.billing_org_id}_${var.customer}_${var.project_group}_${var.env}_cloud-functions"
  source_archive_object = "classify.zip"
  entry_point = "classify"
}
