resource "google_storage_bucket" "getting_started_demo" {
  name     = "${var.project_id}-getting-started-demo-tf-${terraform.workspace}" #(1)!
  location = var.location
}

resource "google_service_account" "getting_started_demo" {
  account_id  = "getting-started-demo-tf-${terraform.workspace}"
  description = "Demo service account created by the get started tutorial"
}

resource "google_storage_bucket_iam_binding" "getting_started_demo" {
  bucket  = google_storage_bucket.getting_started_demo.name
  role    = "roles/storage.objectUser"
  members = [
    google_service_account.getting_started_demo.member
  ]
}

resource "google_cloud_run_v2_service" "getting_started_demo" {
  name     = "cloudrun-getting-started-demo-${terraform.workspace}"
  location = var.location

  template {
    service_account = google_service_account.getting_started_demo.email
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}