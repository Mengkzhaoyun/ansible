#!/bin/bash

set -e

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/kubernetes}"
RKT_ACI_ETCD="${RKT_ACI_ETCD:-etcd-v3.2.0}"
TOOLS_ETCDCTL="${TOOLS_ETCDCTL:-etcdctl-v3.2.10-linux-amd64}"
REGISTRY_LOCAL="${REGISTRY_LOCAL:-}"
REGISTRY_LOCAL_SPLIT="${REGISTRY_LOCAL_SPLIT:-}"
REGISTRY_ETCD_REPO="${REGISTRY_ETCD_REPO:-}"
REGISTRY_ETCD_VERSION="${REGISTRY_ETCD_VERSION:-}"
REGISTRY_ETCDCTL_REPO="${REGISTRY_ETCDCTL_REPO:-}"
REGISTRY_ETCDCTL_VERSION="${REGISTRY_ETCDCTL_VERSION:-}"

mkdir -p /etc/kubernetes/downloads
mkdir -p /etc/kubernetes/data

if [[ -e /etc/kubernetes/downloads/$RKT_ACI_ETCD.aci ]]; then
	echo 'etcd aci is already exist!'
else
  if [[ -n "${REGISTRY_LOCAL:-}" ]]; then
    rkt --insecure-options=http,image fetch docker://$REGISTRY_LOCAL$REGISTRY_ETCD_REPO$REGISTRY_LOCAL_SPLIT$REGISTRY_ETCD_VERSION
    REGISTRY_LOCAL_RKT=$(echo $REGISTRY_LOCAL | sed 's/:/_/g')
    rkt image export $REGISTRY_LOCAL_RKT$REGISTRY_ETCD_REPO$REGISTRY_LOCAL_SPLIT$REGISTRY_ETCD_VERSION /etc/kubernetes/downloads/$REGISTRY_ETCD_REPO-$REGISTRY_ETCD_VERSION.aci
  else
    curl $HTTP_SERVER/$RKT_ACI_ETCD.tgz > /etc/kubernetes/downloads/$RKT_ACI_ETCD.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$RKT_ACI_ETCD.tgz
    rm -rf /etc/kubernetes/downloads/$RKT_ACI_ETCD.tgz
    echo 'registry aci download completed!'
  fi
fi

if ! [ -x "$(command -v etcdctl)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$TOOLS_ETCDCTL ]]; then
    if [[ -n "${REGISTRY_LOCAL:-}" ]]; then
      docker run -v /etc/kubernetes/downloads:/data/output --rm $REGISTRY_LOCAL$REGISTRY_ETCDCTL_REPO$REGISTRY_LOCAL_SPLIT$REGISTRY_ETCDCTL_VERSION
    else
      curl $HTTP_SERVER/$TOOLS_ETCDCTL.tgz > /etc/kubernetes/downloads/$TOOLS_ETCDCTL.tgz
    fi
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$TOOLS_ETCDCTL.tgz
    rm -rf /etc/kubernetes/downloads/$TOOLS_ETCDCTL.tgz    
  fi
  chmod 0744 /etc/kubernetes/downloads/$TOOLS_ETCDCTL
  rm -rf /usr/bin/etcdctl
  ln -s /etc/kubernetes/downloads/$TOOLS_ETCDCTL /usr/bin/etcdctl
fi