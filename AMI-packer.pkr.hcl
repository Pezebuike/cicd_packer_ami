 
# packer {
#   required_plugins {
#     amazon = {
#       version = ">= 0.0.2"
#       source  = "github.com/hashicorp/amazon"
#     }
#   }
# }

# source "amazon-ebs" "ec2" {
#   ami_name      = "${var.ami_prefix}-${local.timestamp}"
#   instance_type = "t2.micro"
#   region        = "us-east-1"
#   vpc_id        = "${var.vpc}"
#   subnet_id     = "${var.subnet}"
#   security_group_ids = ["${var.sg}"]
#   ssh_username = "ec2-boy-oh-boy"
#   source_ami_filter {
#     filters = {
#       name                = "amzn2-ami-hvm-2.0*"
#       root-device-type    = "ebs"
#       virtualization-type = "hvm"
#     }
#     most_recent = true
#     owners      = ["12345567896"]
#   }
#   launch_block_device_mappings = [
#     {
#         "device_name": "/dev/xvda",
#         "delete_on_termination": true
#         "volume_size": 10
#         "volume_type": "gp2"
#     }
#    ]
#   run_tags = "${var.tags}"
#   run_volume_tags = "${var.tags}"
# }

# build {
#   sources = [
#     "source.amazon-ebs.ec2"
#   ]
# }