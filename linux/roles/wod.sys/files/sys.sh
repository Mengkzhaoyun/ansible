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

require_ev_all REGISTRY_LOCAL_IP

REGISTRY_LOCAL_HOST="${REGISTRY_LOCAL_HOST:-reg.local}"
REGISTRY_LOCAL_IP="${REGISTRY_LOCAL_IP}"
AUTHORIZED_KEYS="${AUTHORIZED_KEYS}"
ENV_OPT="$PATH:/opt/bin"

if ! (grep -q ${REGISTRY_LOCAL_HOST} /etc/hosts) ; then
  echo "" >> /etc/hosts;
  echo "${REGISTRY_LOCAL_IP} ${REGISTRY_LOCAL_HOST}" >> /etc/hosts;
else
  sed -i "/${REGISTRY_LOCAL_HOST}/c\\${REGISTRY_LOCAL_IP} ${REGISTRY_LOCAL_HOST}" /etc/hosts
fi

if ! (grep -q /opt/bin /etc/environment) ; then
  sed -i "/PATH=/c\PATH=${ENV_OPT}" /etc/environment
  source /etc/environment;
fi

if ! [[ -e /usr/bin/mkdir ]]; then
  /bin/mkdir -p /usr/bin
  ln -s /bin/mkdir /usr/bin/mkdir
fi

if ! [[ -e /root/.ssh/authorized_keys ]]; then
  mkdir -p /root/.ssh/
  touch /root/.ssh/authorized_keys create file
fi

IFS=","
KEYS=(${AUTHORIZED_KEYS})
for key in ${KEYS[@]}; do
  IFS=" "
  keyarr=(${key})
  if ! (grep -q ${keyarr[2]} /root/.ssh/authorized_keys) ; then
    echo " " >> /root/.ssh/authorized_keys;
    echo "${key}" >> /root/.ssh/authorized_keys;
  fi
done

mkdir -p /etc/kubernetes/scripts /etc/kubernetes/manifests /etc/kubernetes/addon /usr/share/ca-certificates