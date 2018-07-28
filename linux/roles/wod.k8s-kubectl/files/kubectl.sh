#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/k8s/latest}"
DEP_KUBECTL="${DEP_KUBECTL:-kubectl-v1.9.0}" 
MASTER_SERVER="${MASTER_SERVER}" 
CA_CERT=/etc/kubernetes/ssl/ca.pem
ADMIN_KEY=/etc/kubernetes/ssl/admin.key
ADMIN_CERT=/etc/kubernetes/ssl/admin.pem

mkdir -p /etc/kubernetes/downloads
mkdir -p /opt/bin

if ! [ -x "$(command -v kubectl)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$DEP_KUBECTL ]]; then
    curl $HTTP_SERVER/$DEP_KUBECTL.tgz > /etc/kubernetes/downloads/$DEP_KUBECTL.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEP_KUBECTL.tgz
    rm -rf /etc/kubernetes/downloads/$DEP_KUBECTL.tgz    
  fi
  chmod 0744 /etc/kubernetes/downloads/$DEP_KUBECTL
  ln -s /etc/kubernetes/downloads/$DEP_KUBECTL /opt/bin/kubectl
  /opt/bin/kubectl config set-cluster kubernetes --server=http://127.0.0.1:8080
  /opt/bin/kubectl config set-context kubernetes --cluster=kubernetes 
  /opt/bin/kubectl config use-context kubernetes
fi