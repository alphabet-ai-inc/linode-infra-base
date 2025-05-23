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
