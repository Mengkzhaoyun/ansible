#!/bin/bash 

set -e  

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/k8s/latest}"
ACI_ETCD="${ACI_ETCD:-etcd-v3.2.0}" 

mkdir -p /etc/kubernetes/downloads

if [[ -e /etc/kubernetes/downloads/$ACI_ETCD.aci ]]; then
  echo 'etcd aci is already exist!'
else
  curl $HTTP_SERVER/$ACI_ETCD.tgz > /etc/kubernetes/downloads/$ACI_ETCD.tgz
  cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$ACI_ETCD.tgz
  rm -rf /etc/kubernetes/downloads/$ACI_ETCD.tgz
  echo 'etcd aci download completed!'
fi

DEP_ETCDCTL="${DEP_ETCDCTL:-etcdctl-v3.2.10-linux-amd64}" 
if ! [ -x "$(command -v etcdctl)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$DEP_ETCDCTL ]]; then
    curl $HTTP_SERVER/$DEP_ETCDCTL.tgz > /etc/kubernetes/downloads/$DEP_ETCDCTL.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEP_ETCDCTL.tgz
    rm -rf /etc/kubernetes/downloads/$DEP_ETCDCTL.tgz    
  fi
  chmod 0744 /etc/kubernetes/downloads/$DEP_ETCDCTL
  ln -s /etc/kubernetes/downloads/$DEP_ETCDCTL /usr/bin/etcdctl
fi

ACI_FLANNEL="${ACI_FLANNEL:-flannel-v0.7.1}"

if [[ -e /etc/kubernetes/downloads/$ACI_FLANNEL.aci ]]; then
  echo 'flannel aci is already exist!'
else
  curl $HTTP_SERVER/$ACI_FLANNEL.tgz > /etc/kubernetes/downloads/$ACI_FLANNEL.tgz
  cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$ACI_FLANNEL.tgz
  rm -rf /etc/kubernetes/downloads/$ACI_FLANNEL.tgz
  echo 'flannel aci download completed!'
fi

ACI_KUBELET="${ACI_KUBELET:-hyperkube-v1.7.3}"

if [[ -e /etc/kubernetes/downloads/$ACI_KUBELET.aci ]]; then
  echo 'kubelet aci is already exist!'  
else
  curl $HTTP_SERVER/$ACI_KUBELET.tgz > /etc/kubernetes/downloads/$ACI_KUBELET.tgz
  cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$ACI_KUBELET.tgz
  rm -rf /etc/kubernetes/downloads/$ACI_KUBELET.tgz
  echo 'kubelet aci download completed!'
fi

if [[ -e /etc/rkt/net.d/10-containers.conf ]]; then
  echo 'rkt net containers is ready!'
else
  mkdir -p /etc/rkt/net.d
  echo '{ 
    "name": "containers", 
    "type": "bridge", 
    "ipam": { 
      "type": "host-local", 
      "subnet": "172.17.0.0/16" 
    } 
}' \
  > /etc/rkt/net.d/10-containers.conf
  echo 'rkt net containers is ready!'
fi