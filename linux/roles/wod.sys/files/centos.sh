#!/bin/bash

systemctl stop firewalld && systemctl disable firewalld

if grep -q SELINUX=enforcing /etc/selinux/config ; then  
  setenforce 0;
  sed -i 's@SELINUX=enforcing@SELINUX=disabled@' /etc/selinux/config;
fi 