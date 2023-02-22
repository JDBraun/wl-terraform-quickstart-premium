variable "databricks_account_username" {
  type = string
  sensitive = true
}

variable "databricks_account_password" {
  type = string
  sensitive = true
}

variable "databricks_account_id" {
  type = string
  sensitive = true
}

variable "aws_access_key" {
  type = string
  sensitive = true
}

variable "aws_secret_key" {
  type = string
  sensitive = true
}

variable "data_bucket" {
  type = string
  sensitive = true
}

variable "resource_owner" {
  type = string
  sensitive = true
}

variable "resource_prefix" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr_range" {
  type = string
}

variable "private_subnets_cidr" {
  type = string
}

variable "public_subnets_cidr" {
  type = string
}

variable "privatelink_subnets_cidr" {
  type = string
}

variable "availability_zones" {
  type = string
}

variable "customer_name" {
  type = string
}

variable "authoritative_user_email" {
  type = string
}

variable "authoritative_user_full_name" {
  type = string
}

variable "sidebarLogoActive" {
  type = string
}

variable "sidebarLogoInactive" {
  type = string
}

variable "sidebarLogoText" {
  type = string
}

variable "homePageWelcomeMessage" {
  type = string
}

variable "homePageLogo" {
  type = string
}

variable "homePageLogoWidth" {
  type = string
}

variable "productName" {
  type = string
}

variable "loginLogo" {
  type = string
}

variable "loginLogoWidth" {
  type = string
}