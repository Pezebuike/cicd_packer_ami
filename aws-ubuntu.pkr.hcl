packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws-ubuntutest"
  instance_type = "t2.micro"
  region        = "ap-southeast-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}
build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}


# packer {
#   required_plugins {
#     amazon = {
#       version = ">= 1.2.8"
#       source  = "github.com/hashicorp/amazon"
#     }
#   }
# }

# source "amazon-ebs" "ubuntu" {
#   ami_name      = var.ami_name
#   instance_type = var.instance_type
#   region        = var.region

#   source_ami_filter {
#     filters = var.ami_filters
#     most_recent = true
#     owners = var.ami_owners
#   }

#   ssh_username = var.ssh_username
# }

# build {
#   name    = "learn-packer"
#   sources = [
#     "source.amazon-ebs.ubuntu"
#   ]
# }
