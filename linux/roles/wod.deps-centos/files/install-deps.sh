#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/k8s}"
YUM_SERVER="${YUM_SERVER:-https://gitlab.ispacesys.cn/source/cig/raw/master/centos}"
YUM_RKT="${YUM_RKT:-rkt_1.29.0-1_amd64.rpm}"

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

if ! [ -x "$(command -v rkt)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$YUM_RKT ]]; then
    curl $HTTP_SERVER/$YUM_RKT.tgz > /etc/kubernetes/downloads/$YUM_RKT.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$YUM_RKT.tgz
    rm -rf /etc/kubernetes/downloads/$YUM_RKT.tgz    
  fi
  rpm -Uvh /etc/kubernetes/downloads/$YUM_RKT
fi 