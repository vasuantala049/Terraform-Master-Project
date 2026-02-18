resource "aws_instance" "ec2_instances" {
    count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_ids[count.index%length(var.subnet_ids)]
  vpc_security_group_ids = [ var.app_sg_id ]
  iam_instance_profile = var.instance_profile_name
  associate_public_ip_address = false
  monitoring = true
  root_block_device {
    encrypted = true
  }

  tags = {
    Name        = "${var.environment}-app-instance-${count.index + 1}"
    Environment = var.environment
  }
  
}