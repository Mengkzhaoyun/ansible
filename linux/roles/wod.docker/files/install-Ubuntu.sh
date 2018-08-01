#!/bin/bash

set -e

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/k8s}"
DEB_LIBLTDL7="${DEB_LIBLTDL7:-libltdl7_2.4.6-0.1_amd64}"
DEB_DOCKER="${DEB_DOCKER:-docker-engine_1.13.1-0~ubuntu-xenial_amd64}"
DEB_IPTABLE="${DEB_IPTABLE:-iptables_1.6.0-2ubuntu3_amd64}"

mkdir -p /etc/kubernetes/downloads

if ! [ -x "$(command -v docker)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$DEB_LIBLTDL7.deb ]]; then
    curl $HTTP_SERVER/$DEB_LIBLTDL7.tgz > /etc/kubernetes/downloads/$DEB_LIBLTDL7.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEB_LIBLTDL7.tgz
    rm -rf /etc/kubernetes/downloads/$DEB_LIBLTDL7.tgz
  fi
  if ! [[ -e /etc/kubernetes/downloads/$DEB_DOCKER.deb ]]; then
    curl $HTTP_SERVER/$DEB_DOCKER.tgz > /etc/kubernetes/downloads/$DEB_DOCKER.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEB_DOCKER.tgz
    rm -rf /etc/kubernetes/downloads/$DEB_DOCKER.tgz
  fi
  dpkg -i /etc/kubernetes/downloads/$DEB_LIBLTDL7.deb
  dpkg -i /etc/kubernetes/downloads/$DEB_DOCKER.deb
fi

if ! [ -x "$(command -v iptables)" ]; then
  if ! [[ -e /etc/kubernetes/downloads/$DEB_IPTABLE.deb ]]; then
    curl $HTTP_SERVER/$DEB_IPTABLE.tgz > /etc/kubernetes/downloads/$DEB_IPTABLE.tgz
    cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEB_IPTABLE.tgz
    rm -rf /etc/kubernetes/downloads/$DEB_IPTABLE.tgz
  fi
  dpkg -i /etc/kubernetes/downloads/$DEB_IPTABLE.deb
fi