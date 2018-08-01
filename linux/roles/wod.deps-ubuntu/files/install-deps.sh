#!/bin/bash

set -e

HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/k8s}"
DEP_LIBLTDL7="${DEP_LIBLTDL7:-libltdl7_2.4.6-0.1_amd64}"
DEP_IPTABLE="${DEP_IPTABLE:-iptables_1.6.0-2ubuntu3_amd64}"
DEP_DOCKER="${DEP_DOCKER:-docker-engine_1.13.1-0~ubuntu-xenial_amd64}"
DEP_RKT="${DEP_RKT:-rkt_1.29.0-1_amd64}"

mkdir -p /etc/kubernetes/downloads

if ! [ -x "$(command -v docker)" ]; then
    if ! [[ -e /etc/kubernetes/downloads/$DEP_LIBLTDL7.deb ]]; then
        curl $HTTP_SERVER/$DEP_LIBLTDL7.tgz > /etc/kubernetes/downloads/$DEP_LIBLTDL7.tgz
        cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEP_LIBLTDL7.tgz
        rm -rf /etc/kubernetes/downloads/$DEP_LIBLTDL7.tgz
    fi
    if ! [[ -e /etc/kubernetes/downloads/$DEP_DOCKER.deb ]]; then
        curl $HTTP_SERVER/$DEP_DOCKER.tgz > /etc/kubernetes/downloads/$DEP_DOCKER.tgz
        cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEP_DOCKER.tgz
        rm -rf /etc/kubernetes/downloads/$DEP_DOCKER.tgz
    fi
    dpkg -i /etc/kubernetes/downloads/$DEP_LIBLTDL7.deb
    dpkg -i /etc/kubernetes/downloads/$DEP_DOCKER.deb
fi

if ! [ -x "$(command -v iptables)" ]; then
    if ! [[ -e /etc/kubernetes/downloads/$DEP_IPTABLE.deb ]]; then
        curl $HTTP_SERVER/$DEP_IPTABLE.tgz > /etc/kubernetes/downloads/$DEP_IPTABLE.tgz
        cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEP_IPTABLE.tgz
        rm -rf /etc/kubernetes/downloads/$DEP_IPTABLE.tgz
    fi
    dpkg -i /etc/kubernetes/downloads/$DEP_IPTABLE.deb
fi

if ! [ -x "$(command -v rkt)" ]; then
    if ! [[ -e /etc/kubernetes/downloads/$DEP_RKT.deb ]]; then
        curl $HTTP_SERVER/$DEP_RKT.tgz > /etc/kubernetes/downloads/$DEP_RKT.tgz
        cd /etc/kubernetes/downloads && tar -xzf /etc/kubernetes/downloads/$DEP_RKT.tgz
        rm -rf /etc/kubernetes/downloads/$DEP_RKT.tgz
    fi
    dpkg -i /etc/kubernetes/downloads/$DEP_RKT.deb
fi