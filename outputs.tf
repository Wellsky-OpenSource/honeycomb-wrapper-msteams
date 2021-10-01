output "function_http_url" {
  value = google_cloudfunctions_function.function_event.https_trigger_url
}

output "id" {
  description = "The Id of the Function"
  value       = google_cloudfunctions_function.function_event.id
}


output "project" {
  description = "The project of the created resource"
  value       = google_cloudfunctions_function.function_event.project
}

output "region" {
  description = "The region of the deployed Function"
  value       = google_cloudfunctions_function.function_event.region
}