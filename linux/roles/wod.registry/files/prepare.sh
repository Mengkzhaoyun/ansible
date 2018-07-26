#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/k8s/latest}"
RKT_ACI_REGISTRY="${RKT_ACI_REGISTRY:-registry-2.6.2}"
RKT_ACI_REGISTRY_DATA="${RKT_ACI_REGISTRY_DATA:-registry-data-v1.9.0}"

mkdir -p /etc/kubernetes/downloads

if [[ -e /etc/kubernetes/downloads/$RKT_ACI_REGISTRY.aci ]]; then
  echo 'registry aci is already exist!'
else
  curl $HTTP_SERVER/$RKT_ACI_REGISTRY.tgz > /etc/kubernetes/downloads/$RKT_ACI_REGISTRY.tgz
  cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$RKT_ACI_REGISTRY.tgz
  rm -rf /etc/kubernetes/downloads/$RKT_ACI_REGISTRY.tgz
  echo 'registry aci download completed!'
fi

if [[ -e /data/registry/docker ]]; then
  echo 'registry data ready!'
else
  curl $HTTP_SERVER/$RKT_ACI_REGISTRY_DATA.tgz > /etc/kubernetes/downloads/$RKT_ACI_REGISTRY_DATA.tgz
  cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$RKT_ACI_REGISTRY_DATA.tgz
  rm -rf /etc/kubernetes/downloads/$RKT_ACI_REGISTRY_DATA.tgz
  mkdir -p /data/registry
  mv -n /etc/kubernetes/downloads/data/docker /data/registry
  rm -rf /etc/kubernetes/downloads/data
fi