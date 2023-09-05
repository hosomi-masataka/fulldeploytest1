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