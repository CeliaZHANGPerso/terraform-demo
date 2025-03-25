terraform {
  required_providers {
    google = { #(1)!
      source  = "hashicorp/google"
      version = "5.24.0"
    }
  }
  backend "local" {} #(2)!
}

provider "google" { #(3)!
  project = "${var.project_id}"
}
