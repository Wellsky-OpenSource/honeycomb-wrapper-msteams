variable "source_dir" {
  type        = string
  description = "Name of the directory with Function Code"
  default     = "function"
}
variable "environment_variables" {
  type        = map(string)
  description = "A set of key/value environment variable pairs to assign to the function"
  default     = { URL = "<Replace the URL for the MS teams Channel>" } # Replace the <> braces with the URL for the MS teams channel
}
variable "project_id" {
  type        = string
  description = "Google Cloud Platform project id"
  default     = "test-project" #Replace the Project ID with your GCP Project ID
}

variable "region" {
  type        = string
  description = "Region for Cloud Functions and accompanying resources"
  default     = "us-central1" #Change the location to the Desired Location for deploying Cloud Function
}

variable "bucket_name" {
  type        = string
  description = "Name of the GCP Bucket which will hold the Python Code for the Wrapper"
  default     = "test-bucket" #Change the bucket name to the desired bucket name
}