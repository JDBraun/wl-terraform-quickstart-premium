locals {
  prefix                       = var.resource_prefix
  owner                        = var.resource_owner
  vpc_cidr_range               = var.vpc_cidr_range
  private_subnets_cidr         = split(",", var.private_subnets_cidr)
  public_subnets_cidr          = split(",", var.public_subnets_cidr)
  privatelink_subnets_cidr     = split(",", var.privatelink_subnets_cidr)
  sg_egress_ports              = [443, 3306]
  sg_ingress_protocol          = ["tcp", "udp"]
  sg_egress_protocol           = ["tcp", "udp"]
  availability_zones           = split(",", var.availability_zones)
  dbfsname                     = join("", [local.prefix, "-", var.region, "-", "dbfsroot"]) 
  data_bucket                  = var.data_bucket
}

// Create External Databricks Workspace
module "databricks_mws_workspace" {
  source = "./modules/databricks_workspace"
  providers = {
    databricks = databricks.mws
  }

  databricks_account_id        = var.databricks_account_id
  resource_prefix              = local.prefix
  security_group_ids           = [aws_security_group.sg.id]
  subnet_ids                   = aws_subnet.private[*].id
  vpc_id                       = aws_vpc.dataplane_vpc.id
  cross_account_role_arn       = aws_iam_role.cross_account_role.arn
  bucket_name                  = aws_s3_bucket.root_storage_bucket.id
  region                       = var.region
  customer_name                = var.customer_name
  authoritative_user_email     = var.authoritative_user_email
  authoritative_user_full_name = var.authoritative_user_full_name
}

// Add Optional WL Co-Branding Features
module "wl_co_branding" {
  source = "./modules/wl_co_branding"
  providers = {
    databricks = databricks.created_workspace
  }

  sidebarLogoActive = var.sidebarLogoActive
  sidebarLogoInactive = var.sidebarLogoInactive
  sidebarLogoText = var.sidebarLogoText
  homePageWelcomeMessage = var.homePageWelcomeMessage
  homePageLogo = var.homePageLogo
  homePageLogoWidth = var.homePageLogoWidth
  productName = var.productName
  loginLogo = var.loginLogo
  loginLogoWidth = var.loginLogoWidth
  depends_on = [module.databricks_mws_workspace]
}

// Admin configurations
module "admin_configuration" {
  source = "./modules/admin_configuration"
  providers = {
    databricks = databricks.created_workspace
  }

  depends_on = [module.databricks_mws_workspace]
}

// Cluster configurations
module "cluster_configuration" {
  source = "./modules/cluster_configuration"
  providers = {
    databricks = databricks.created_workspace
  }

  instance_profile = aws_iam_instance_profile.s3_instance_profile.arn
  customer_name = var.customer_name
  depends_on = [module.databricks_mws_workspace]
}