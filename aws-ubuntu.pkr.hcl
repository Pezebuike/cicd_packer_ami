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
      # Set non-interactive mode to avoid prompts
      "export DEBIAN_FRONTEND=noninteractive",

      # Update sources list to use HTTPS
      "sudo sed -i 's|http://archive.ubuntu.com/ubuntu|https://archive.ubuntu.com/ubuntu|g' /etc/apt/sources.list",

      # Clean APT cache and remove corrupted lists
      "sudo rm -rf /var/lib/apt/lists/*",
      "sudo apt-get clean",

      # Install required dependencies (gnupg for GPG keys and curl)
      "sudo apt-get update -y",
      "sudo apt-get install -y gnupg curl",

      # Create the directory for keyrings if it doesn't exist
      "sudo mkdir -p /usr/share/keyrings",

      # Add the GPG key for the repository securely with proper permissions
      "curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo gpg --batch --yes --no-tty --dearmor -o /usr/share/keyrings/nginx-archive-keyring.gpg",

      # Add the official NGINX repository
      "echo 'deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx' | sudo tee /etc/apt/sources.list.d/nginx.list > /dev/null",

      # Update the package list and install NGINX
      "sudo apt-get update -y",
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
