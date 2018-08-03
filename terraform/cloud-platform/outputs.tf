output "cluster_name" {
  value = "${local.cluster_name}"
}

output "cluster_domain_name" {
  value = "${local.cluster_base_domain_name}"
}

output "network_id" {
  value = "${module.cluster_vpc.vpc_id}"
}

output "network_cidr_block" {
  value = "${module.cluster_vpc.vpc_cidr_block}"
}

output "kops_state_store" {
  value = "${data.terraform_remote_state.global.kops_state_store}"
}

output "availability_zones" {
  value = "${var.availability_zones}"
}

output "vpc_id" {
  value = "${module.cluster_vpc.vpc_id}"
}

output "internal_subnets" {
  value = "${var.internal_subnets}"
}

output "internal_subnets_ids" {
  value = "${module.cluster_vpc.private_subnets}"
}

output "external_subnets" {
  value = "${var.external_subnets}"
}

output "external_subnets_ids" {
  value = "${module.cluster_vpc.public_subnets}"
}

output "hosted_zone_id" {
  value = "${module.cluster_dns.cluster_dns_zone_id}"
}

output "instance_key_public" {
  value = "${tls_private_key.cluster.public_key_openssh}"
}
