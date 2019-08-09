variable "location" {
  description = "The GCP Location in which resources are created"
  type        = string
}

variable "project" {
  description = "The GCP Project in which resources are created, typically $project_group-$env"
  type        = string
}

variable "document_client_image" {
  description = "The Document Frontend Docker Image"
  type        = string
}

variable "classify_backend_url" {
  description = "The Classify Backend URL"
  type        = string
}
