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

if ! (grep -q /opt/bin /etc/environment) ; then
  echo "PATH=${ENV_OPT}" >> /etc/environment
  source /etc/environment;
fi

if [[ -e /lib64/libncurses.so.5.9 ]]; then
  if [[ -e $HOME/bin/python ]]; then
    ln -s $HOME/bin/python /opt/bin/python
    exit 0 
  fi

  if [[ -e $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2 ]]; then
    tar -xjf $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2
    rm -rf $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2
  else
    curl $HTTP_SERVER/pypy-$PYPY_VERSION-linux64.tar.bz2 > $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2 
    tar -xjf $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2
    rm -rf $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2
  fi

  mv -n pypy-$PYPY_VERSION-linux64 pypy

  ## library fixup
  mkdir -p pypy/lib
  ln -snf /lib64/libncurses.so.5.9 $HOME/pypy/lib/libtinfo.so.5

  ## add for centos
  ln -snf /lib64/libbz2.so.1.0.6 $HOME/pypy/lib/libbz2.so.1.0

  mkdir -p $HOME/bin

  chmod +x $HOME/pypy/bin/pypy

  cat > $HOME/bin/python <<EOF
#!/bin/bash
LD_LIBRARY_PATH=$HOME/pypy/lib:$LD_LIBRARY_PATH exec $HOME/pypy/bin/pypy "\$@"
EOF

  chmod +x $HOME/bin/python
  $HOME/bin/python --version

  rm -rf /opt/bin/python

  ln -s $HOME/bin/python /opt/bin/python
  exit 0 
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