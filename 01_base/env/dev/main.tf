/* -------------- 基本設定 --------------*/
# Providerバージョン
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider設定
## awsプロバイダ
provider "aws" {
  region = "ap-northeast-1"
}

/* -------------- 各種モジュール設定 --------------*/
module "network" {
  source                     = "./../../modules/network/"
  env                        = var.env
  vpc_cider                  = var.vpc_cider
  az01                       = var.az01
  az02                       = var.az02
  public_subnet01_cider      = var.public_subnet01_cider
  public_subnet02_cider      = var.public_subnet02_cider
  private_subnet01_cider     = var.private_subnet01_cider
  ssh_access_cider           = var.ssh_access_cider
}



module "ec2" {
  source           = "./../../modules/ec2/"
  env              = var.env
  public_key_id    = aws_key_pair.ssh_keypair.id
  private_key_path = local_file.ec2-user_private_key_file.filename
  vpc_id           = module.network.vpc_id
  public_subnet01  = module.network.public_subnet01
  private_subnet01 = module.network.private_subnet01

  sg_ec2_step      = module.network.sg_ec2_step
  sg_ec2_private01 = module.network.sg_ec2_private01

  ec2_step_ami_id        = var.ec2_step_ami_id
  ec2_step_instance_type = var.ec2_step_instance_type
  ec2_step_volume_size   = var.ec2_step_volume_size
  ec2_step_volume_type   = var.ec2_step_volume_type
  ec2_step_private_ip    = var.ec2_step_private_ip

  ec2_private01_ami_id        = var.ec2_private01_ami_id
  ec2_private01_instance_type = var.ec2_private01_instance_type
  ec2_private01_volume_size   = var.ec2_private01_volume_size
  ec2_private01_volume_type   = var.ec2_private01_volume_type
  ec2_private01_private_ip    = var.ec2_private01_private_ip
}


module "monitor" {
  source = "./../../modules/monitor"
  env    = var.env
  sns_email01 = var.sns_email01
  sns_email02 = var.sns_email03
  sns_email03 = var.sns_email03
  ec2_instance_id_step = module.ec2.ec2_instance_id_step
  ec2_instance_id_private01 = module.ec2.ec2_instance_id_private01
}

