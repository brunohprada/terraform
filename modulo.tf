module "VPC" {
  source = "modulos/"
  compute_subnetwork_ip_cidr_range = "10.6.108.0/24"
  compute_subnetwork_prefix_name = "abc"
}