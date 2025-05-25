# Linode VPC and Firewall Terraform Project

This Terraform project provisions a Virtual Private Cloud (VPC), a Cloud Firewall and Object Storage Bucket on Linode (Akamai Cloud Computing). The VPC is created in a specified region, and the firewall is configured with rules to allow inbound SSH (port 22), HTTP (port 80), and HTTPS (port 443) traffic, with a default policy to drop other inbound traffic and allow all outbound traffic.

## Features

- **VPC Creation**: Provisions a VPC with a customizable name and region.
- **Cloud Firewall**: Configures a firewall with inbound rules for SSH, HTTP, and HTTPS, and allows all outbound traffic.
- **Object Storage bucket**: Provisions a Object Storage bucket with a customizable name and region.
- **Output**: Displays:
  - vpc_id 
  - firewall_id
  - region: region for VPC and subnet
  - subnet_id

## Prerequisites

- Terraform installed (version 1.0 or higher). Install via:
  - [Official HashiCorp Terraform Installation](https://developer.hashicorp.com/terraform/install)
  - [Linode Terraform Installation Guide](https://www.linode.com/docs/guides/create-a-multicloud-infrastructure-using-terraform/)
- A Linode API token with `read/write` permissions for:
  - `VPCs`
  - `Firewalls`
  - `Linodes`
  - `Events`
  - `Object Storage`
- The API token stored in a file named `~/.linode_token` in your home directory.

## Project Structure

- `main.tf`: Defines the VPC and Cloud Firewall resources.
- `variables.tf`: Contains variables for the region, VPC name, and firewall name.
- `outputs.tf`: Outputs the VPC ID and Firewall ID.
- `provider.tf`: Configures the Linode provider.

## Setup

1. **Clone the repository or copy the Terraform files** to your project directory.
2. **Ensure the Linode API token** is available:
   - Place the token in a file named `~/.linode_token` in your home directory:

     ```bash
     echo -n "your_api_token" > ~/.linode_token
     ```

3. **Verify the region**:
   - The default region is set to `us-iad` (Washington, DC) in `variables.tf`, which supports VPCs.
   - To find other regions supporting VPCs or Object Storages, you can use `regions.tf` to list available regions with `terraform plan`, then update `variables.tf` accordingly.

## Usage

1. **Initialize Terraform**:

   ```bash
   terraform init
   ```

2. **Preview the plan**:

   ```bash
   terraform plan
   ```

3. **Apply the configuration**:
  Before execution `terraform apply` execute:
   ```bash
   export AWS_REQUEST_CHECKSUM_CALCULATION=when_required  
   export AWS_RESPONSE_CHECKSUM_VALIDATION=when_required
   ```


   ```bash
   terraform apply
   ```

   Confirm with `yes` when prompted.

4. **Check outputs**: After applying, the VPC ID and Firewall ID will be displayed:

```
Outputs:
firewall_id = <firewall_id>
region = <region_id>
subnet_id = <subnet_id>
vpc_id = <vpc_id>
```

## Configuration Details

- **VPC**:
  - Resource: `linode_vpc.alphabet_vpc`
  - Label: Configured via `var.vpc_name`.
  - Region: Configured via `var.region` (default: `us-iad`).
- **Cloud Firewall**:
  - Resource: `linode_firewall.alphabet_firewall`
  - Label: Configured via `var.firewall_name`.
  - **Inbound Rules**:
    - Allow SSH (TCP port 22) from all IPv4/IPv6 addresses.
    - Allow HTTP (TCP port 80) from all IPv4/IPv6 addresses.
    - Allow HTTPS (TCP port 443) from all IPv4/IPv6 addresses.
    - Default policy: `DROP` (blocks all other inbound traffic).
  - **Outbound Rules**:
    - Allow all TCP traffic (ports 1-65535) to all IPv4/IPv6 addresses.
    - Default policy: `ACCEPT`.

## Variables

| Variable | Description | Default |
| --- | --- | --- |
| `region` | Linode region for VPC | `us-iad` |
| `vpc_name` | Name of the VPC | (Defined in `variables.tf`) |
| `firewall_name` | Name of the Cloud Firewall | (Defined in `variables.tf`) |


## Troubleshooting

- **Region Error**: If you see `[400] This region does not support VPCs`, update `var.region` in `variables.tf` to a supported region (e.g., `us-iad`, `it-mil`, `us-mia`, `fr-par`). You can use a temporary `data "linode_regions"` block in `regions.tf` to list supported regions.
- **Token Error**: If you encounter `[401] Your OAuth token is not authorized`, ensure the API token in `~/.linode_token` has `read/write` permissions for `Firewalls`, `VPCs`, and `Linodes`. Create a new token in Linode Cloud Manager if needed. For deleting resources you need permissions for `Events`.
- **Provider Installation**: If you face issues with provider installation, ensure the `.terraformrc` file in the project directory is correctly configured to use the official Terraform Registry for `linode/linode`.

## Notes

- The Linode provider version is pinned to `2.40.0` in `provider.tf`. Check the [Terraform Registry](https://registry.terraform.io/providers/linode/linode/latest) for updates.
- Ensure the region supports VPCs (e.g., `us-iad`, `it-mil`, `us-mia`, `fr-par`).
- For additional firewall rules, modify the `inbound` or `outbound` blocks in `main.tf`.
- The API token is read from `~/.linode_token` to prevent accidental inclusion in version control.
