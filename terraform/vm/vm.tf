resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-micro"
  zone         = "europe-west3-a"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
      size  = 25
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
