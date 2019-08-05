resource "aws_key_pair" "jumpbox_key" {
  key_name   = "jumpbox_key"
  public_key = var.public_key
}

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
