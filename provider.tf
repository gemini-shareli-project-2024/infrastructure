terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.59.0" 
    }
  }
}

provider "google" {
  project     = "shareli-gemini-2024"
  region      = "asia-northeast1-b"
  credentials = file(var.google_credentials)
}
variable "google_credentials" {
  description = "Google Cloud credentials in JSON format"
  type        = string
  sensitive   = true
}



