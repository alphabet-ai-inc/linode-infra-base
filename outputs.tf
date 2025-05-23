output "vpc_id" {
    description = "The ID of the created VPC"
    value = linode_vpc.alphabet_vpc.id
}

output "firewall_id" {
    description = "Firewall"
    value = linode_firewall.alphabet_firewall.id
}

output "subnet_id" {
    description = "Subnet"
    value = linode_vpc_subnet.alphabet_vpc_subnet.id
}
