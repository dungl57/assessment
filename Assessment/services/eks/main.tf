module "eks" {
  source = "../../modules/eks"

  environment                  = var.environment
  cluster_name                 = var.cluster_name
  kubernetes_version           = var.kubernetes_version
  region                       = var.region
  vpc_id                       = var.vpc_id
  subnet_ids                   = var.subnet_ids
  node_group_subnet_ids        = var.node_group_subnet_ids
  enabled_cluster_log_types    = var.enabled_cluster_log_types
  cluster_encryption_cmk_arn   = var.cluster_encryption_cmk_arn
  endpoint_private_access      = var.endpoint_private_access
  endpoint_public_access       = var.endpoint_public_access
  control_plane_allowed_ip_ranges = var.control_plane_allowed_ip_ranges
  default_tags                 = var.default_tags
}
