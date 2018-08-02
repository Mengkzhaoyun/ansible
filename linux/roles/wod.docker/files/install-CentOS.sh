#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/kubernetes}"
YUM_SERVER="$HTTP_SERVER/centos"

mkdir -p /etc/kubernetes/downloads

if ! [ -x "$(command -v docker)" ]; then
  cd /etc/yum.repos.d
  if ! [[ -e /etc/yum.repos.d/bak ]]; then
    mkdir bak
    mv CentOS-* bak
  fi
  tee /etc/yum.repos.d/localyum.repo <<-EOF
[localyum]
name=localyum
baseurl=${YUM_SERVER}
enable=1
gpgcheck=0
EOF
  yum install -y docker
fi