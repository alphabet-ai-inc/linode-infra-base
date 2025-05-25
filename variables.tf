variable "region" {
    description = "Linode region for resources"
    type        = string
    default     = "us-iad"
}

variable "vpc_name" {
    description = "VPC name"
    type = string
    default = "alphabet-ai-net"
}

variable "firewall_name" {
    description = "Firewall name"
    type = string
    default = "alphabet-ai-firewall"
}

variable "bucket_name" {
  description = "Name of the Object Storage bucket"
  type        = string
  default     = "infra-config"
}

variable "bucket_region" {
  description = "Not all VPC regions work with Objects Storages"
  type        = string
  default     = "us-ord"
}
