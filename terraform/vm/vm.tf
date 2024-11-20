resource "google_compute_instance" "default" {
  for_each = toset([ for num in range(16) : "alunno-${num}" ])

  name         = "${each.value}"
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
