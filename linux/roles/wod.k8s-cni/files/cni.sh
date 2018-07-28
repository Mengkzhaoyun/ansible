#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/k8s/latest}"
K8S_CNI_BIN="${K8S_CNI_BIN:-cni-plugins-amd64-v0.7.0}"

mkdir -p /opt/cni/bin

if [[ -e /opt/cni/bin/host-local ]]; then
  echo 'cni bin is already exist!'
else
  curl $HTTP_SERVER/$K8S_CNI_BIN.tgz > /opt/cni/bin/$K8S_CNI_BIN.tgz
  cd /opt/cni/bin && tar -xzf /opt/cni/bin/$K8S_CNI_BIN.tgz
  rm -rf /opt/cni/bin/$K8S_CNI_BIN.tgz
  echo 'cni bin download completed!'
fi