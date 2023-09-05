/* -------------- リソース名設定 --------------*/
## 環境名（開発・ステージング・本番）を指定。作成されるリソース名の先頭にこの変数に入れた文字がくるように設定
variable "env" {
  default = "test-ec2-env-amazonlinux"
}
## 小文字しかインスタンス名に使えないリソース用
variable "env_lowercase" {
  default = "test-ec2-env-amazonlinux"
}

/* -------------- 基本設定 --------------*/
## 仕様するリージョン
variable "region" {
  default = "ap-northeast-1"
}

/* -------------- 各種リソース設定 --------------*/
## ネットワーク
### VPC CIDER
variable "vpc_cider" {
  default = "10.0.0.0/16"
}

### 使用するリージョン
variable "az01" {
  default = "ap-northeast-1a"
}
variable "az02" {
  default = "ap-northeast-1c"
}

### パブリックサブネット１
variable "public_subnet01_cider" {
  default = "10.0.10.0/24"
}

### パブリックサブネット２
variable "public_subnet02_cider" {
  default = "10.0.11.0/24"
}

### プライベートサブネット１
variable "private_subnet01_cider" {
  default = "10.0.20.0/24"
}

## EC2
### 踏み台サーバ設定
#### AMI ID
variable "ec2_step_ami_id" {
  default = "ami-08c84d37db8aafe00"
}
#### インスタンスタイプ
variable "ec2_step_instance_type" {
  default = "t3.micro"
}
#### ボリュームサイズ
variable "ec2_step_volume_size" {
  default = "10"
}
#### ボリュームタイプ
variable "ec2_step_volume_type" {
  default = "gp2"
}
#### プライベートIP
variable "ec2_step_private_ip" {
  default = "10.0.10.10"
}
#### 踏み台へのSSH接続を許可するIPレンジ
##### ※Provisionerの設定でEC2へのSSH接続を行っているため、Terraformの実行環境がCloud9からとかだとパナIPでSSH制限かけていると、Provisionerの実行ができない
variable "ssh_access_cider" {
  default = "0.0.0.0/0"
}

### プライベートサブネット内のサーバ設定
#### AMI ID
variable "ec2_private01_ami_id" {
  default = "ami-08c84d37db8aafe00"
}
#### インスタンスタイプ
variable "ec2_private01_instance_type" {
  default = "t3.micro"
}
#### ボリュームサイズ
variable "ec2_private01_volume_size" {
  default = "10"
}
#### ボリュームタイプ
variable "ec2_private01_volume_type" {
  default = "gp2"
}
#### プライベートIP
variable "ec2_private01_private_ip" {
  default = "10.0.20.10"
}

### SNS登録メールアドレス（Cloudwatchアラート通知先）
variable "sns_email01" {
  default = "d84230da.jppanasonic.onmicrosoft.com@apac.teams.ms"
}

variable "sns_email02" {
  default = "c3c1bb4c.jppanasonic.onmicrosoft.com@apac.teams.ms"
}

variable "sns_email03" {
  default = "4510ea62.jppanasonic.onmicrosoft.com@apac.teams.ms"
}