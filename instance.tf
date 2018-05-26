resource "google_compute_instance" "default" {
  name = "test"
  machine_type = "f1-micro"
  zone = "southamerica-east1-c"

  tags = ["foo", "bar"]

  boot_disk {
      initialize_params {
          image = "debian-cloud/debian-9"
      }
  }

  // Local SSD disk
  scratch_disk {

  }

  network_interface {
      network = "default"

      access_config {
          // Ephemeral IP
      }
  }

  metadata {
      foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
      scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

