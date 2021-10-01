terraform {
  # minimum allowed version
  required_version = ">= 0.13.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.58.0"
    }
  }
}