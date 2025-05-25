# Bucket for tfstate, .env files, etc.
resource "linode_object_storage_bucket" "infra_config_bucket" {
  region      = var.bucket_region
  label       = var.bucket_name
  versioning  = false
  acl         = "private"
}

# Access key for bucket
resource "linode_object_storage_key" "bucket_access_key" {
  label = "${var.bucket_name}-access-key"

  bucket_access {
    bucket_name = var.bucket_name
    region      = var.bucket_region
    permissions = "read_write"
  }
  depends_on = [linode_object_storage_bucket.infra_config_bucket]
}

# Output
output "bucket" {
  description = "Details of the Object Storage bucket"
  value = {
    name        = linode_object_storage_bucket.infra_config_bucket.label
    region      = linode_object_storage_bucket.infra_config_bucket.region
    access_key  = linode_object_storage_key.bucket_access_key.access_key
    secret_key  = linode_object_storage_key.bucket_access_key.secret_key
  }
  sensitive = true
}