#!/bin/bash 

set -e 
 
function require_ev_all() {
	for rev in $@ ; do 
		if [[ -z "${!rev}" ]]; then
			echo ${rev} is not set
			exit 1
		fi
	done
}

require_ev_all HOSTS_REGISTRY_IP

HOSTS_REGISTRY="${HOSTS_REGISTRY:-reg.local}"
HOSTS_REGISTRY_IP="${HOSTS_REGISTRY_IP}"
AUTHORIZED_KEYS="${AUTHORIZED_KEYS}"
HOSTS_ETCD="${HOSTS_ETCD}"
ENV_OPT="$PATH:/opt/bin"

if grep -q ${HOSTS_REGISTRY} /etc/hosts ; then  
  echo `grep ${HOSTS_REGISTRY} /etc/hosts`;
else 
  echo "${HOSTS_REGISTRY_IP} ${HOSTS_REGISTRY}" >> /etc/hosts; 
fi 

if grep -q /opt/bin /etc/environment ; then  
  echo `grep /opt/bin /etc/environment`;
else 
  echo "PATH=${ENV_OPT}" >> /etc/environment
  source /etc/environment; 
fi 


if ! [[ -e /usr/bin/mkdir ]]; then
  /bin/mkdir -p /usr/bin
  ln -s /bin/mkdir /usr/bin/mkdir
fi

if [[ -e /root/.ssh/authorized_keys ]]; then
  echo 'authorized_keys is already exist!'
else
  mkdir -p /root/.ssh/
  touch /root/.ssh/authorized_keys create file
fi

IFS="," 
KEYS=(${AUTHORIZED_KEYS}) 
for key in ${KEYS[@]}; do 
  IFS=" " 
  keyarr=(${key})
  if grep -q ${keyarr[2]} /root/.ssh/authorized_keys ; then 
    echo `grep ${keyarr[2]} /root/.ssh/authorized_keys`;
  else 
    echo "${key}" >> /root/.ssh/authorized_keys; 
  fi 
done 

IFS="," 
ETCDHOSTS=(${HOSTS_ETCD}) 
for etcdhost in ${ETCDHOSTS[@]}; do 
  IFS=" " 
  hostarr=(${etcdhost})
  if grep -q ${hostarr[0]}  /etc/hosts ; then 
    echo `grep ${hostarr[0]} /etc/hosts`;
  else 
    echo "${hostarr[0] ${hostarr[1]" >> /etc/hosts; 
  fi 
done 