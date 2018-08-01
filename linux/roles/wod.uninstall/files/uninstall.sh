#!/bin/bash 

systemctl daemon-reload

SERVICE=k8s-kubelet

if [ "`systemctl is-active $SERVICE`" == "active" ] ; then  
  systemctl stop $SERVICE
  rm -rf /etc/systemd/system/$SERVICE.service
fi

SERVICE=k8s-etcd

if [ "`systemctl is-active $SERVICE`" == "active" ] ; then  
  systemctl stop $SERVICE
  rm -rf /etc/systemd/system/$SERVICE.service
fi

SERVICE=k8s-registry

if [ "`systemctl is-active $SERVICE`" == "active" ] ; then  
  systemctl stop $SERVICE
  rm -rf /etc/systemd/system/$SERVICE.service
fi

docker rm $(docker ps -a | awk '{print $1}') -f

rkt gc --grace-period=0

rkt image gc --grace-period=0

rm -rf /etc/kubernetes /etc/cni/net.d /opt/cni/bin