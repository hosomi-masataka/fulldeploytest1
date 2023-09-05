#!/bin/bash
# AWS開発環境構築用シェル

## ユーザ登録関数（引数　$1:username,$2:key）
function create_user(){
    ## ログインユーザの追加
    useradd -m $1
    ## sudoグループにユーザを追加
    usermod -aG wheel $1
    ## パスワード設定
    echo $3 | passwd --stdin $1
    ## ssh設定
    mkdir /home/$1/.ssh
    touch /home/$1/.ssh/authorized_keys
    echo $2 >> /home/$1/.ssh/authorized_keys
    chown $1:$1 /home/$1/.ssh
    chown $1:$1 /home/$1/.ssh/authorized_keys
    chmod 700 /home/$1/.ssh
    chmod 600 /home/$1/.ssh/authorized_keys
}

# 管理者権限で以下のスクリプトを実行
sudo su

# 1:ec2-user以外ユーザの登録
## IFSの設定を変更しないとスペースが区切り文字として認識されてしまうため、echoでauthorized_keysに公開鍵情報を登録した際に、鍵の内容が途中で途切れてしまうので、シェルの実行の間だけ、IFSを空に設定。
#OLDIFS=$IFS
#IFS=

## 公開鍵の中身を変数に格納
#key_testuser="*******"
#password_testuser="**********"
#create_user testuser $key_testuser $password_testuser
#IFS=$OLDIFS

# 2:TeraTermでSSH接続する際に必要になる設定（署名アルゴリズムssh-rsaを許可する設定　※脆弱になるので注意）
## デフォルトの設定ファイルのバックアップを取得
#cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config_$(date +%Y%m%d)
## Configファイルにssh-rsaを許可する設定を追加
#sed -i '1s/^/PubkeyAcceptedAlgorithms=+ssh-rsa\n/' /etc/ssh/sshd_config
## サービスを再起動
#systemctl restart sshd.service