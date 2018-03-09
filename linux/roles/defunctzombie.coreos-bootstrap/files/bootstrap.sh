#!/bin/bash  

set -e 
  
cd
 
if [[ -e $HOME/.bootstrapped ]]; then
  exit 0 
fi

HTTP_SERVER="${HTTP_SERVER:-https://gitlab.ispacesys.cn/source/cig/raw/master/k8s}" 
PYPY_VERSION=5.1.0

if [[ -e $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2 ]]; then
  tar -xjf $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2
  rm -rf $HOME/pypy-$PYPY_VERSION-linux64.tar.bz2
else
  # wget -O - $HTTP_SERVER/pypy-$PYPY_VERSION-linux64.tar.bz2 |tar -xjf -
  curl $HTTP_SERVER/pypy-$PYPY_VERSION-linux64.tgz > $HOME/pypy-$PYPY_VERSION-linux64.tgz 
  tar -xzf $HOME/pypy-$PYPY_VERSION-linux64.tgz
  rm -rf $HOME/pypy-$PYPY_VERSION-linux64.tgz
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

touch $HOME/.bootstrapped