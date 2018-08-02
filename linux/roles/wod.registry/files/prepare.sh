#!/bin/bash

set -e

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/kubernetes}"
RKT_ACI_REGISTRY="${RKT_ACI_REGISTRY:-registry-2.6.2}"
RKT_ACI_REGISTRY_DATA="${RKT_ACI_REGISTRY_DATA:-registry-data-v1.9.0}"
REGISTRY_REMOTE="${REGISTRY_REMOTE:-}"
REGISTRY_REMOTE_SPLIT="${REGISTRY_REMOTE_SPLIT:-}"
REGISTRY_REGISTRY_REPO="${REGISTRY_REGISTRY_REPO:-}"
REGISTRY_REGISTRY_VERSION="${REGISTRY_REGISTRY_VERSION:-}"

mkdir -p /etc/kubernetes/downloads
mkdir -p /etc/kubernetes/data

if [[ -e /etc/kubernetes/downloads/$RKT_ACI_REGISTRY.aci ]]; then
	echo 'registry aci is already exist!'
else
  if [[ -n "${REGISTRY_REMOTE:-}" ]]; then
    rkt --insecure-options=image fetch docker://$REGISTRY_REMOTE$REGISTRY_REGISTRY_REPO$REGISTRY_REMOTE_SPLIT$REGISTRY_REGISTRY_VERSION
    rkt image export $REGISTRY_REMOTE$REGISTRY_REGISTRY_REPO$REGISTRY_REMOTE_SPLIT$REGISTRY_REGISTRY_VERSION /etc/kubernetes/downloads/$REGISTRY_REGISTRY_REPO-$REGISTRY_REGISTRY_VERSION.aci
  else
    curl $HTTP_SERVER/$RKT_ACI_REGISTRY.tgz > /etc/kubernetes/downloads/$RKT_ACI_REGISTRY.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$RKT_ACI_REGISTRY.tgz
    rm -rf /etc/kubernetes/downloads/$RKT_ACI_REGISTRY.tgz
    echo 'registry aci download completed!'
  fi
fi

if [[ -e /etc/kubernetes/data/registry/docker ]]; then
	echo 'registry data ready!'
else
  if [[ -n "${REGISTRY_REMOTE:-}" ]]; then
    echo 'registry data from remote!'
  else
    curl $HTTP_SERVER/$RKT_ACI_REGISTRY_DATA.tgz >/etc/kubernetes/downloads/$RKT_ACI_REGISTRY_DATA.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$RKT_ACI_REGISTRY_DATA.tgz
    rm -rf /etc/kubernetes/downloads/$RKT_ACI_REGISTRY_DATA.tgz
    mkdir -p /etc/kubernetes/data/registry
    mv -n /etc/kubernetes/downloads/data/docker /etc/kubernetes/data/registry
    rm -rf /etc/kubernetes/downloads/data
  fi
fi
