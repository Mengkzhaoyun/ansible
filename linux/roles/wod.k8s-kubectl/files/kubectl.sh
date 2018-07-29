#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/k8s/latest}"
TOOLS_KUBECTL="${TOOLS_KUBECTL:-kubectl-v1.9.0}"

mkdir -p /etc/kubernetes/downloads
mkdir -p /opt/bin

if ! [ -x "$(command -v kubectl)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$TOOLS_KUBECTL ]]; then
    curl $HTTP_SERVER/$TOOLS_KUBECTL.tgz > /etc/kubernetes/downloads/$TOOLS_KUBECTL.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$TOOLS_KUBECTL.tgz
    rm -rf /etc/kubernetes/downloads/$TOOLS_KUBECTL.tgz    
  fi
  chmod 0744 /etc/kubernetes/downloads/$TOOLS_KUBECTL
  ln -s /etc/kubernetes/downloads/$TOOLS_KUBECTL /opt/bin/kubectl
  /opt/bin/kubectl config set-cluster kubernetes --server=http://127.0.0.1:8080
  /opt/bin/kubectl config set-context kubernetes --cluster=kubernetes
  /opt/bin/kubectl config use-context kubernetes
fi