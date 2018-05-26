// teste de provisionamento de rede

resource "google_compute_network" "default" {
  name = "lab-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "default" {
  name = "lab-subnetwork"
  description = "descrição da sub-net"
  ip_cidr_range = "10.5.108.0/23"
  network = "${google_compute_network.default.self_link}"
  region = "southamerica-east1"
  private_ip_google_access = "true"
}

resource "google_compute_firewall" "default" {
  name = "fw-allow-ssh"
  network = "${google_compute_network.default.name}"

  allow {
      protocol = "tcp"
      ports = ["22"]
  }

  target_tags = ["linux"]
}

resource "google_compute_firewall" "default" {
  name = "fw-allow-icmp"
  network = "${google_compute_network.default.name}"

  allow {
      protocol = "icmp"
  }

  target_tags = ["linux", "windows"]
}




