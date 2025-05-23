# https://registry.terraform.io/providers/linode/linode/latest/docs/data-sources/regions
data "linode_regions" "vpc_regions" {
  filter {
    name = "status"
    values = ["ok"]
  }

  filter {
    name   = "capabilities"
    values = ["VPCs"]
  }
}

# To list all regions for VPCs:
# output "regions" {
#     value  = [for region in data.linode_regions.vpc_regions.regions : region.id]
# }
