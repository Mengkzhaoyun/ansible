#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/kubernetes}"
YUM_SERVER="$HTTP_SERVER/centos"

mkdir -p /etc/kubernetes/downloads

if ! [ -x "$(command -v docker)" ]; then
  curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
fi