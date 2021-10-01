data "archive_file" "zip" {
  type        = "zip"
  source_dir  = "${path.module}/${var.source_dir}/"
  output_path = "${path.module}/files/index.zip"
}

resource "google_storage_bucket" "bucket" {
  project = var.project_id
  name    = var.bucket_name
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.zip.output_path
}

resource "google_cloudfunctions_function" "function_event" {
  name                  = "python-honeycomb-wrapper-msteams"
  description           = "python-honeycomb-wrapper-opensource"
  runtime               = "python38"
  project               = var.project_id
  region                = var.region
  available_memory_mb   = 256
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "honeycomb_trigger"
  environment_variables = var.environment_variables
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function_event.project
  region         = google_cloudfunctions_function.function_event.region
  cloud_function = google_cloudfunctions_function.function_event.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}