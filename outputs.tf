output "function_url" {
  description = "The URL of the deployed cloud function"
  value       = google_cloudfunctions_function.function.https_trigger_url
}