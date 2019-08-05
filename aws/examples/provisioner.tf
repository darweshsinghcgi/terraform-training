resource "aws_instance" "jumpbox" {
  ami = var.ami_id # pinning to a version prevents recreation when there's a new image available.
  instance_type = "m5.xlarge"
  associate_public_ip_address = true
  key_name = "${aws_key_pair.jumpbox_key.key_name}"
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  provisioner "local_exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }

  provisioner "remote_exec" {
    command = "ifconfig"
  }

  provisioner "file" {
    source = "./blah.blah"
    destination "~/blah.blah"
  }
}
