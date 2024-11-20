terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "itis-441214"
}

data "google_client_config" "default" {}
