resource "google_service_account" "default" {
  account_id   = "terraform"
  display_name = "Shareli"
}

resource "google_storage_bucket" "terraform_state_bucket" {
  name          = "shareli-terraform-state"
  location      = "asia-southeast1" 
  force_destroy = true 
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}

resource "google_compute_instance" "default" {
  name         = "shareli"
  machine_type = "e2-standard-2"
  zone         = "asia-southeast1-b"

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "apt-get update -y && sudo apt-get install -y docker.io && sudo usermod -aG docker $USER "

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

terraform {
   backend "gcs" {
     bucket  = "shareli-terraform-state"
     prefix  = "infrastructure"
   }
}
