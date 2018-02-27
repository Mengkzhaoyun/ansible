#!/bin/bash  
set -e 

cd /etc/kubernetes/ssl    
 
if [[ -e /etc/kubernetes/ssl/kubeproxy.key ]]; then
  echo 'kubeproxy.key is ready!'
else
  openssl genrsa -out kubeproxy.key 2048
  echo 'kubeproxy.key is ready!'
fi

if [[ -e /etc/kubernetes/ssl/kubeproxy.pem ]]; then
  echo 'kubeproxy.pem is ready!'
else
  openssl req -new -key kubeproxy.key -out kubeproxy.csr -subj "/CN=admin/C=CN/ST=BeiJing/L=Beijing/O=system:masters/OU=System" -config worker-kubeproxy.cnf
  openssl x509 -req -in kubeproxy.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out kubeproxy.pem -days 365 -extensions v3_req -extfile worker-kubeproxy.cnf
  echo 'kubeproxy.pem is ready!'
fi

if [[ -e /etc/kubernetes/ssl/kubelet.key ]]; then
  echo 'kubelet.key is ready!'
else
  openssl genrsa -out kubelet.key 2048
  echo 'kubelet.key is ready!'
fi

if [[ -e /etc/kubernetes/ssl/kubelet.pem ]]; then
  echo 'kubelet.pem is ready!'
else
  openssl req -new -key kubelet.key -out kubelet.csr -subj "/CN=admin/C=CN/ST=BeiJing/L=Beijing/O=system:masters/OU=System" -config worker-kubelet.cnf 
  openssl x509 -req -in kubelet.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out kubelet.pem -days 365 -extensions v3_req -extfile worker-kubelet.cnf  
  echo 'kubelet.pem is ready!'
fi