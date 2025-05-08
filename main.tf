terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a Cloud Function
resource "google_cloudfunctions_function" "function" {
  name        = "hello-world-function"
  description = "Simple HTTP-triggered function that prints Hello world!"
  runtime     = "python310"
  
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.function_bucket.name
  source_archive_object = google_storage_bucket_object.function_archive.name
  trigger_http          = true
  entry_point           = "hello_world"
  timeout               = 60
  
  # Ensure all traffic is directed to latest revision
  max_instances         = 1
}

# Create a bucket to store the function source code
resource "google_storage_bucket" "function_bucket" {
  name     = "${var.project_id}-function-bucket"
  location = var.region
  uniform_bucket_level_access = true
}

# Create an archive of the function source code
data "archive_file" "function_source" {
  type        = "zip"
  source_dir  = "${path.module}/function-source"
  output_path = "${path.module}/function-source.zip"
}

# Upload the function source code to the bucket
resource "google_storage_bucket_object" "function_archive" {
  name   = "function-source-${data.archive_file.function_source.output_md5}.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = data.archive_file.function_source.output_path
}

# Make the function publicly accessible
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name
  
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}