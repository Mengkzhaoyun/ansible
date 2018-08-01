FROM registry.ispacesys.cn/cig/data:1.0.0
MAINTAINER Shu Cheng <shucheng@spacesystech.com>

ENV HTTP_SERVER=http://k8s.spacecig.com/softs/k8s

RUN mkdir -p /data/input \
&& curl $HTTP_SERVER/kubectl.tgz > /data/input/kubectl.tgz