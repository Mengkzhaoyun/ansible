#!/bin/bash 

set -e  

K8S_HOST="${K8S_HOST:-}"
K8S_ROLE="${K8S_ROLE:-worker}"

mkdir -p /opt/cni/bin

if [ $K8S_ROLE == "master" ] ; then
  kubectl label node $K8S_HOST node-role.kubernetes.io/master="true" --overwrite
else
  kubectl label node $K8S_HOST node-role.kubernetes.io/node="true" --overwrite
fi