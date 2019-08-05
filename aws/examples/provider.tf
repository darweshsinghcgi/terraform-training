provider "aws" {
  version = "~> 2.0"
  region = var.region
}

provider "aws" {
  version = "~> 2.0"
  alias = "provider2"
  region = var.region2
}

resource "aws_instance" "jumpbox" {
  provider = aws.provider2
  ami = var.ami_id # pinning to a version prevents recreation when there's a new image available.
  instance_type = "m5.xlarge"
  associate_public_ip_address = true
  key_name = "${aws_key_pair.jumpbox_key.key_name}"
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]
}
