#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-https://gitlab.ispacesys.cn/source/cig/raw/master/k8s}"
YUM_SERVER="${YUM_SERVER:-https://gitlab.ispacesys.cn/source/cig/raw/master/centos}"
DEP_RKT="${DEP_RKT:-rkt_1.29.0-1_amd64}"

mkdir -p /etc/kubernetes/downloads

if ! [ -x "$(command -v docker)" ]; then
  cd /etc/yum.repos.d
  mv CentOS-* bak
  dpkg -i /etc/kubernetes/downloads/$DEP_LIBLTDL7.deb
  dpkg -i /etc/kubernetes/downloads/$DEP_DOCKER.deb
fi

if ! [ -x "$(command -v rkt)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$DEP_RKT.deb ]]; then
    curl $HTTP_SERVER/$DEP_RKT.tgz > /etc/kubernetes/downloads/$DEP_RKT.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEP_RKT.tgz
    rm -rf /etc/kubernetes/downloads/$DEP_RKT.tgz    
  fi
  dpkg -i /etc/kubernetes/downloads/$DEP_RKT.deb
fi 