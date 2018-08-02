#!/bin/bash

set -e

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/kubernetes}"
RKT_ACI_KUBELET="${RKT_ACI_KUBELET:-hyperkube-v1.10.6}"
REGISTRY_LOCAL="${REGISTRY_LOCAL:-}"
REGISTRY_LOCAL_SPLIT="${REGISTRY_LOCAL_SPLIT:-}"
REGISTRY_KUBELET_REPO="${REGISTRY_KUBELET_REPO:-}"
REGISTRY_KUBELET_VERSION="${REGISTRY_KUBELET_VERSION:-}"

mkdir -p /etc/kubernetes/downloads
mkdir -p /etc/kubernetes/data

if [[ -e /etc/kubernetes/downloads/$RKT_ACI_KUBELET.aci ]]; then
	echo 'kubelet aci is already exist!'
else
  if [[ -n "${REGISTRY_LOCAL:-}" ]]; then
    rkt --insecure-options=http,image fetch docker://$REGISTRY_LOCAL$REGISTRY_KUBELET_REPO$REGISTRY_LOCAL_SPLIT$REGISTRY_KUBELET_VERSION
    REGISTRY_LOCAL_RKT=$(echo $REGISTRY_LOCAL | sed 's/:/_/g')
    rkt image export $REGISTRY_LOCAL_RKT$REGISTRY_KUBELET_REPO$REGISTRY_LOCAL_SPLIT$REGISTRY_KUBELET_VERSION /etc/kubernetes/downloads/$REGISTRY_KUBELET_REPO-$REGISTRY_KUBELET_VERSION.aci
  else
    curl $HTTP_SERVER/$RKT_ACI_KUBELET.tgz > /etc/kubernetes/downloads/$RKT_ACI_KUBELET.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$RKT_ACI_KUBELET.tgz
    rm -rf /etc/kubernetes/downloads/$RKT_ACI_KUBELET.tgz
    echo 'kubelet aci download completed!'
  fi
fi