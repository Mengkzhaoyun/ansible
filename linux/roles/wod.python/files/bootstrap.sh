#!/bin/bash  

set -e 
  
HTTP_SERVER="${HTTP_SERVER:-http://k8s.spacecig.com/softs/kubernetes}" 
PYPY_VERSION=5.1.0
ActivePython="ActivePython-2.7.14.2717-linux-x86_64-glibc-2.12-404899"
ENV_OPT="$PATH:/opt/bin"

mkdir -p /opt/bin

if [[ -e /opt/bin/python ]]; then
  exit 0 
fi

if [[ -e /usr/bin/python ]]; then
  ln -s /usr/bin/python /opt/bin/python
  exit 0 
fi

if ! (grep -q /opt/bin /etc/environment) ; then
  echo "PATH=${ENV_OPT}" >> /etc/environment
  source /etc/environment;
fi

if [[ -e /opt/$ActivePython.tar.gz ]]; then
  echo '$ActivePython.tar.gz exist!'
else
  curl $HTTP_SERVER/$ActivePython.tar.gz > /opt/$ActivePython.tar.gz
fi
cd /opt
tar -xzvf $ActivePython.tar.gz
cd /opt/${ActivePython} && ./install.sh -I /opt/python/
cd /opt
rm -rf /opt/$ActivePython.tar.gz /opt/$ActivePython
ln -sf /opt/python/bin/easy_install /opt/bin/easy_install
ln -sf /opt/python/bin/pip /opt/bin/pip
ln -sf /opt/python/bin/python /opt/bin/python
ln -sf /opt/python/bin/python /opt/bin/python2
ln -sf /opt/python/bin/virtualenv /opt/bin/virtualenv