variable "env" {}
variable "vpc_id" {}
variable "public_key_id" {}
variable "private_key_path" {}
variable "public_subnet01" {}
variable "private_subnet01" {}

variable "sg_ec2_step" {}
variable "sg_ec2_private01" {}

variable "ec2_step_ami_id" {}
variable "ec2_step_instance_type" {}
variable "ec2_step_volume_size" {}
variable "ec2_step_volume_type" {}
variable "ec2_step_private_ip" {}

variable "ec2_private01_ami_id" {}
variable "ec2_private01_instance_type" {}
variable "ec2_private01_volume_size" {}
variable "ec2_private01_volume_type" {}
variable "ec2_private01_private_ip" {}