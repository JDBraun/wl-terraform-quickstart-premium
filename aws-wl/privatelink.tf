// VPC Endpoints
module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.11.0"

  vpc_id             = aws_vpc.dataplane_vpc.id
  security_group_ids = [aws_security_group.sg.id]

  endpoints = {
    s3 = {
      count = length(local.private_subnets_cidr)
      service      = "s3"
      service_type = "Gateway"
      route_table_ids = flatten([
        aws_route_table.private_rt[*].id
      ])
      tags = {
        Name = "${local.prefix}-s3-vpc-endpoint"
      }
    },
    sts = {
      service             = "sts"
      private_dns_enabled = true
      subnet_ids          = aws_subnet.private[*].id
      tags = {
        Name = "${local.prefix}-sts-vpc-endpoint"
      }
    },
    kinesis-streams = {
      service             = "kinesis-streams"
      private_dns_enabled = true
      subnet_ids          = aws_subnet.private[*].id
      tags = {
        Name = "${local.prefix}-kinesis-vpc-endpoint"
      }
    }
  }
}