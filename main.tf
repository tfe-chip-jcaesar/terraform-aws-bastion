resource "aws_security_group" "bastionHost" {
  name        = "sg_${var.name}"
  description = "Security Group for Bastion Host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Private Inbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ Name = "sg_BastionHost" }, var.common_tags)
}

resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.size
  key_name                    = var.ssh_key
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastionHost.id]

  tags = merge({ Name = var.name }, var.common_tags)
}
