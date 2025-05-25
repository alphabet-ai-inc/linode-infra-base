# https://registry.terraform.io/providers/linode/linode/latest/docs/data-sources/regions
# https://api.linode.com/v4/regions
data "linode_regions" "vpc_regions" {
  filter {
    name   = "status"
    values = ["ok"]
  }

  filter {
    name = "capabilities"
    # values = ["VPCs"]
    values = ["Object Storage"]
  }
}

# To list all regions for VPCs uncomment this and run `terraform plan`
# output "regions" {
#     value  = [for region in data.linode_regions.vpc_regions.regions : region.id]
# }
