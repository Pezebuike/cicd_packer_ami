variable "ami_name" {
  type    = string
  default = "learn-packer-linux-aws-test"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "ami_filters" {
  type = map(string)
  default = {
    name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
}

variable "ami_owners" {
  type    = list(string)
  default = ["099720109477"]
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}
