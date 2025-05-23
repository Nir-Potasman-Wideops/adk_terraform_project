variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region to deploy the resources to"
  type        = string
  default     = "us-central1"
}