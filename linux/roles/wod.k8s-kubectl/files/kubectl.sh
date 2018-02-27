#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-https://gitlab.ispacesys.cn/source/cig/raw/master/k8s}"
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
  /opt/bin/kubectl config set-cluster kubernetes --server=https://$MASTER_SERVER --certificate-authority=$CA_CERT --embed-certs=true
  /opt/bin/kubectl config set-credentials admin --certificate-authority=$CA_CERT --client-key=$ADMIN_KEY --client-certificate=$ADMIN_CERT --embed-certs=true
  /opt/bin/kubectl config set-context kubernetes --cluster=kubernetes --user=admin
  /opt/bin/kubectl config use-context kubernetes
fi