// teste de provisionamento de rede

resource "google_compute_network" "default" {
  name = "${var.compute_network_name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "default" {
  name = "${var.compute_subnetwork_prefix_name}-lab-subnetwork"
  description = "descrição da sub-net"
  ip_cidr_range = "${var.compute_subnetwork_ip_cidr_range}"
  network = "${compute_network.default.self_link}"
  region = "${var.compute_subnetwork_region}"
  private_ip_google_access = "true"
}

resource "google_compute_firewall" "default" {
  name = "${var.compute_subnetwork_prefix_name}-fw-allow-ssh"
  network = "${compute_network.default.name}"

  allow {
      protocol = "tcp"
      ports = ["22"]
  }

  allow {
      protocol = "icmp"
  }

  target_tags = ["${var.compute_subnetwork_prefix_name}-linux"]
}

resource "google_compute_instance" "default" {
  name = "${var.compute_instance_name}"
  region = "${var.compute_subnetwork_region}"
  machine_type = "${var.compute_instance_machine_type}"
  tags = ""

  boot_disk {
    auto_delete = "true"

    initialize_params {
      image = "centos_cloud/centos-7"
      size = "10"
      type = "pd-ssd"
    }
  }

  network_interface {
    subnetwork = "${compute_subnetwork.default.name}"
  }
}
