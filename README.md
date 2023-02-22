# White Label (WL) - Terraform QuickStart Premium 

This Terraform Quickstart is meant to be a **foundation** for creating reusable White Label Databricks solution within your AWS environment.

**Disclaimers**: 
- This works with Databricks Premium edition. However, we recommend [enterprise](https://github.com/JDBraun/wl-terraform-quickstart) for WL solutions.
- There is no dedicated warranty or support for this Terraform script. Please raise GitHub issues as needed.
- Please contact your Databricks representative if you're interested in a white label solution. This QuickStart will **not** work on a standard Databricks account.
- This QuickStart **will** create a SQL warehouse and data engineering cluster in the workspace. Please be considerate and shut these downs for cost savings.
- Please use proper password security and management. For more information see [here](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables).

# Getting Started

1. Clone this Repo 

2. Install [Terraform](https://developer.hashicorp.com/terraform/downloads)

3. Fill out `example.tfvars` and place in `aws-wl` directory

4. **(Optional):** Fill out `customResources.json` for reference links on Home Page

5. CD into `aws-wl`

5. Run `terraform init`

6. Run `terraform validate`

7. From `aws-wl` directory, run `terraform plan -var-file ../example.tfvars`

8. Run `terraform apply -var-file ../example.tfvars`

# Terraform Script

- **Data Plane Creation:**
    - Workspace Subnets
    - Security Groups
    - NACLs
    - Route Tables
    - NAT Gateway
    - Internet Gateway
    - AWS VPC Endpoints (S3, Kinesis, STS)
    - S3 Root Bucket
    - Cross Account IAM Role + Policy
    - S3 Instance Profile IAM Role + Policy

- **Workspace Deployment:**
    - Credential Configuration
    - Storage Configuration
    - Network Configuration 
    - External User Parameters (i.e. Authoritative User Parameters)

- **Post Workspace Deployment:**
    - Data Engineering Cluster <- commented out for cost savings
    - SQL Warehouse <- commented out for cost savings
    - Instance Profile Registration
    - Co-Branding Option
    
- **Admin Configurations:**
    - Disable Notebook Exporting
    - Disable Upload Data using the UI
    - Disable Download button for notebook results
    - Disable Web Terminal

# Network Diagram

![Architecture Diagram](https://github.com/JDBraun/wl-terraform-quickstart/blob/main/img/White%20Label%20-%20Network%20Topology%20Premium.png)

# Login Screen Example

![Login Screen](https://github.com/JDBraun/wl-terraform-quickstart/blob/main/img/White%20Label%20-%20Login%20Screen%20Example.png)

# Home Screen Example

![Home Screen](https://github.com/JDBraun/wl-terraform-quickstart/blob/main/img/White%20Label%20-%20Home%20Screen%20Example.png)

# Possible Areas of Additional Customization:

- **Security:** Add groups, users, entitlements, and assign IP access lists of your customers:
    - [Group Management](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/group)
    - [User Management](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/user)
    - [Entitlements](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/entitlements)
    - [IP Access List](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/ip_access_list)

- **Cluster Management:** Precreate clusters, restrict the clusters that can be created in the workspace, and assign the proper instance profile: 
    - [Cluster Policy Creation + Assignment](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/cluster_policy)

- **Unity Catalog:** Assign a metastore and catalog to a workspace, then grant only a subset of data for the customer:
    - [Metastore Creation](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/metastore)
    - [Metastore Assignment](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/metastore_assignment)
    - [Catalog Creation + Assignment](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog)
    - [Data Grants](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/grants)

- **Repos:** Preload notebooks that process data: 
    - [Repo Creation](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/repo)
