# Linode VPC and Firewall Terraform Project

This Terraform project provisions a Virtual Private Cloud (VPC) and a Cloud Firewall on Linode (Akamai Cloud Computing). The VPC is created in a specified region, and the firewall is configured with rules to allow inbound SSH (port 22), HTTP (port 80), and HTTPS (port 443) traffic, with a default policy to drop other inbound traffic and allow all outbound traffic.

## Features

- **VPC Creation**: Provisions a VPC with a customizable name and region.
- **Cloud Firewall**: Configures a firewall with inbound rules for SSH, HTTP, and HTTPS, and allows all outbound traffic.
- **Output**: Displays the VPC ID and Firewall ID after provisioning.

## Prerequisites

- Terraform installed (version 1.0 or higher). Install via:
  - [Official HashiCorp Terraform Installation](https://developer.hashicorp.com/terraform/install)
  - [Linode Terraform Installation Guide](https://www.linode.com/docs/guides/create-a-multicloud-infrastructure-using-terraform/)
- A Linode API token with `read/write` permissions for:
  - `VPCs`
  - `Firewalls`
  - `Linodes`
- The API token stored in a file named `~/.linode_token` in your home directory.

## Project Structure

- `main.tf`: Defines the VPC and Cloud Firewall resources.
- `variables.tf`: Contains variables for the region, VPC name, and firewall name.
- `outputs.tf`: Outputs the VPC ID and Firewall ID.
- `provider.tf`: Configures the Linode provider.
- `.terraformrc`: Local Terraform configuration to ensure proper provider installation.

## Setup

1. **Clone the repository or copy the Terraform files** to your project directory.
2. **Ensure the Linode API token** is available:
   - Place the token in a file named `~/.linode_token` in your home directory:

     ```bash
     echo -n "your_api_token" > ~/.linode_token
     ```

3. **Verify the region**:
   - The default region is set to `us-iad` (Washington, DC) in `variables.tf`, which supports VPCs.
   - To find other regions supporting VPCs, you can add a temporary `data "linode_regions"` block to list available regions, then update `variables.tf` accordingly.

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

   ```bash
   terraform apply
   ```

   Confirm with `yes` when prompted.

4. **Check outputs**: After applying, the VPC ID and Firewall ID will be displayed:

   ```
   Outputs:
   vpc_id = <VPC_ID>
   firewall_id = <FIREWALL_ID>
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
| `region` | Linode region for resources | `us-iad` |
| `vpc_name` | Name of the VPC | (Defined in `variables.tf`) |
| `firewall_name` | Name of the Cloud Firewall | (Defined in `variables.tf`) |

## Outputs

| Output | Description |
| --- | --- |
| `vpc_id` | ID of the created VPC |
| `firewall_id` | ID of the created Cloud Firewall |

## Troubleshooting

- **Region Error**: If you see `[400] This region does not support VPCs`, update `var.region` in `variables.tf` to a supported region (e.g., `us-iad`, `it-mil`, `us-mia`, `fr-par`). You can use a temporary `data "linode_regions"` block to list supported regions.
- **Token Error**: If you encounter `[401] Your OAuth token is not authorized`, ensure the API token in `~/.linode_token` has `read/write` permissions for `Firewalls`, `VPCs`, and `Linodes`. Create a new token in Linode Cloud Manager if needed.
- **Provider Installation**: If you face issues with provider installation, ensure the `.terraformrc` file in the project directory is correctly configured to use the official Terraform Registry for `linode/linode`.

## Notes

- The Linode provider version is pinned to `2.40.0` in `provider.tf`. Check the [Terraform Registry](https://registry.terraform.io/providers/linode/linode/latest) for updates.
- Ensure the region supports VPCs (e.g., `us-iad`, `it-mil`, `us-mia`, `fr-par`).
- For additional firewall rules, modify the `inbound` or `outbound` blocks in `main.tf`.
- The API token is read from `~/.linode_token` to prevent accidental inclusion in version control.
