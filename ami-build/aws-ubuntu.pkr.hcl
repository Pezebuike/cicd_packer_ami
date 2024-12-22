# packer {
#   required_plugins {
#     amazon = {
#       source  = "github.com/hashicorp/amazon"
#       version = "~> 1"
#     }
#   }
# }

# source "amazon-ebs" "ubuntu" {
#   ami_name      = "packer-ubuntu-aws-{{timestamp}}"
#   instance_type = "t3.micro"
#   region        = "us-west-2"
#   source_ami_filter {
#     filters = {
#       name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
#       root-device-type    = "ebs"
#       virtualization-type = "hvm"
#     }
#     most_recent = true
#     owners      = ["099720109477"]
#   }
#   ssh_username = "ubuntu"
#   tags = {
#     "Name"        = "MyUbuntuImage"
#     "Environment" = "Production"
#     "OS_Version"  = "Ubuntu 22.04"
#     "Release"     = "Latest"
#     "Created-by"  = "Packer"
#   }
# }
# build {
#   sources = [
#     "source.amazon-ebs.ubuntu"
#   ]
#   provisioner "shell" {
#     inline = [
#       "echo Installing Updates",
#       "sudo apt-get update",
#       "sudo apt-get upgrade -y",
#       "sudo apt-get install -y nginx"
#     ]
#   }

#   post-processor "manifest" {}
# }

#packer build -var-file="variables.pkvars.hcl" .
#packer build -var-file="variables.pkvars.hcl" -var-file="dev.pkvars.hcl" -var-file="prod.pkvars.hcl" -var-file="qa.pkvars.hcl" .