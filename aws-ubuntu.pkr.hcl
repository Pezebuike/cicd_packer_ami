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
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      # Set non-interactive mode
      "export DEBIAN_FRONTEND=noninteractive",

      # Update sources list to use HTTPS
      "sudo sed -i 's|http://archive.ubuntu.com/ubuntu|https://archive.ubuntu.com/ubuntu|g' /etc/apt/sources.list",

      # Clean APT cache
      "sudo rm -rf /var/lib/apt/lists/*",
      "sudo apt-get clean",

      # Install GPG if not installed
      "sudo apt-get install -y gnupg",

      # Add the keyring manually
      "sudo mkdir -p /usr/share/keyrings",
      "curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --no-tty --dearmor -o /usr/share/keyrings/ubuntu-archive-keyring.gpg",

      # Update and upgrade without interaction
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      # Install GPG if not installed
      "sudo apt-get install -y nginx"
    ]
  }

  post-processor "manifest" {}

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
