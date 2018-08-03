#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/kubernetes}"
YUM_SERVER="$HTTP_SERVER/centos"
YUM_RKT="${YUM_RKT:-rkt-1.29.0-1.x86_64.rpm}"

mkdir -p /etc/kubernetes/downloads

if ! [ -x "$(command -v rkt)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$YUM_RKT ]]; then
    curl $YUM_SERVER/$YUM_RKT.tgz > /etc/kubernetes/downloads/$YUM_RKT.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$YUM_RKT.tgz
    rm -rf /etc/kubernetes/downloads/$YUM_RKT.tgz    
  fi
  rpm -Uvh /etc/kubernetes/downloads/$YUM_RKT
fi 