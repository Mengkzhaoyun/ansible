#!/bin/bash  
set -e 

cd /etc/kubernetes/ssl    
 
if [[ -e /etc/kubernetes/ssl/apiserver.key ]]; then
  echo 'apiserver.key is ready!'
else
  openssl genrsa -out apiserver.key 2048
  echo 'apiserver.key is ready!'
fi

if [[ -e /etc/kubernetes/ssl/apiserver.pem ]]; then
  echo 'apiserver.pem is ready!'
else
  openssl req -new -key apiserver.key -out apiserver.csr -subj "/CN=admin/C=CN/ST=BeiJing/L=Beijing/O=system:masters/OU=System" -config master-apiserver.cnf
  openssl x509 -req -in apiserver.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out apiserver.pem -days 3650 -extensions v3_req -extfile master-apiserver.cnf
  echo 'apiserver.pem is ready!'
fi

if [[ -e /etc/kubernetes/ssl/admin.key ]]; then
  echo 'admin.key is ready!'
else
  openssl genrsa -out admin.key 2048
  echo 'admin.key is ready!'
fi

if [[ -e /etc/kubernetes/ssl/admin.pem ]]; then
  echo 'admin.pem is ready!'
else
  openssl req -new -key admin.key -out admin.csr -subj "/CN=admin/C=CN/ST=BeiJing/L=Beijing/O=system:masters/OU=System" -config master-admin.cnf 
  openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out admin.pem -days 3650 -extensions v3_req -extfile master-admin.cnf  
  echo 'admin.pem is ready!'
fi