resource "tls_private_key" "privatekey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.global_tag_prefix}-key" # Create "myKey" to AWS!!
  public_key = tls_private_key.privatekey.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.privatekey.private_key_pem}' > /tmp/${var.global_tag_prefix}.pem"
  }
}

resource "aws_instance" "ec2_instance" {
  ami               = var.ami # Replace with the latest Amazon Linux AMI ID
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_id # Choose the first public subnet
  availability_zone = var.availability_zone
  key_name          = aws_key_pair.keypair.key_name

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-ec2"
  })
}

resource "aws_eip" "ec2_eip" {
  instance = aws_instance.ec2_instance.id

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-eip-ec2"
  })
}

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.availability_zone # Replace with your desired availability zone
  size              = var.ebs_volume_size
  type              = var.ebs_volume_type

  tags = merge(var.global_tags, {
    Name = "${var.global_tag_prefix}-ebs"
  })
}

resource "aws_volume_attachment" "ec2_attachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.ec2_instance.id
}