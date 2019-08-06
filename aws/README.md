# Introduction to Terraform

## Installing Terraform
Download links:
- [macOS](https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_darwin_amd64.zip)
- [Windows](https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_windows_amd64.zip)
- [Linux](https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip)

Installing on Linux/macOS:
1. `unzip terraform-*.zip`
2. `mv terraform* /usr/bin/terraform`
3. `chmod +x usr/bin/terraform`

Installing on Windows:
1. Move the binary to a safe location (Documents, etc.)
2. Go to Control Panel > System > System Settings > Environment Variables
3. On the PATH section, click edit and add your path as follows: `;c:\PATH_TO_BINARY` (replace PATH_TO_BINARY with the location of the binary from step 1 and be sure to include the semicolon at the beginning)
4. Restart any CMD or PowerShell to see Terraform

## Installing and configuring your editor of choice
Download links:
- [Atom](https://github.com/atom/atom/releases) | [Terraform language plugin for Atom](https://atom.io/packages/language-terraform)
- [VS Code](https://code.visualstudio.com/#alt-downloads) | [Terraform language plugin for VS Code](https://marketplace.visualstudio.com/items?itemName=mauve.terraform)

## Building Terraform code
__Important: Always use Terraform's [provider reference](https://www.terraform.io/docs/providers/index.html) when writing Terraform code. It will provide examples of how to use resources and a reference of all resources available and their properties.__

Use the provider reference for AWS to deploy the following resources:
- An Ubuntu jumpbox (a VM with a public IP)
- An SSH key pair (required by the jumpbox)
- An AWS Security group that allows SSH access to the public IP

Use the code in `./infrastructure` as examples of what your code should look like:

```
### TERRAFORM STATE ###
terraform {
  backend "s3" {
    bucket = "tf-state-sandbox-nerdery"
    key = "terraform-infrastructure/state"
    region = "us-east-1"
  }
}

### TERRAFORM PROVIDER ###
provider "aws" {
  version = "~> 2.0"
  region = var.region
}

### JUMPBOX ###
resource "aws_instance" "jumpbox" {
  ami = var.ami_id # pinning to a version prevents recreation when there's a new image available.
  instance_type = "m5.xlarge"
  associate_public_ip_address = true
  key_name = "${aws_key_pair.jumpbox_key.key_name}"
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]
}

### SSH KEY ###
resource "aws_key_pair" "jumpbox_key" {
  key_name   = "jumpbox_key"
  public_key = var.public_key
}

### SECURITY GROUP ###
resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh_jumpbox"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

## Running Terraform code
Visit `deploy_terraform_infrastructure.sh` to see how your infrastructure will be deployed. You can either use that script or run the commands manually:

1. `terraform init`
2. `terraform validate`
3. `terraform plan`
4. `terraform graph`
5. `terraform apply`
6. `terraform destroy`
