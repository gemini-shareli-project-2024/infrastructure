resource "google_service_account" "default" {
  account_id   = "terraform"
  display_name = "Shareli"
}

resource "google_compute_instance" "default" {
  name         = "shareli"
  machine_type = "e2-micro"
  zone         = "asia-northeast1-b"

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
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

  metadata_startup_script = "apt-get update -y && sudo apt-get install -y docker.io"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
