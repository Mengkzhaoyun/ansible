# Offline Auto Deploy Kubernetes 1.9.4 in CentOS

os: CentOS Linux release 7.4.1708 (Core)<br>
cotianer: docker 1.13.1 , rkt 1.29.0<br>
etcd: 3.3.2<br>
kubernetes: 1.9.4<br>
kubernetes-network: kube-router:v0.1.0-rc2<br>
kubernetes-addons: coreos:1.1.0 , dashboard:v1.8.3 , heapster:v1.5.0

<img alt="Schema" src="imgs/centos-schema.png">

Online Vedio<br>
https://www.bilibili.com/video/xxxx<br>
https://www.youtube.com/watch?v=xxxx


# Prepare

CentOS-7-x86_64-Minimal-1708.iso

## 1). 

Modify Machine Name&IP<br>
./linux/centos

Modify k8s Cluster Config<br>
./linux/group_vars/systech

## 2). HTTP_SERVER

http://172.16.11.235/centos<br>

Check the server contians these files：

```bash
# centos docker deps
repodata/922ff602a55376780bc44e186d88fee0e0d45007f515483b171fa6be63dca872-filelists.sqlite.bz2
repodata/9881e0d4922fd8b3991fef570b185cf72006451666456c6b0bfea840e46ce114-other.sqlite.bz2
repodata/ab9d1d915cfa35cfbffd4cdfe2af991854514969d5baf484566396a2a5f1f52e-primary.sqlite.bz2
repodata/c07ddf21b7bf8274641bde5e897d09e6f4ba7441e605d9b341536761356f1094-filelists.xml.gz
repodata/d9a8eb6020167c5df4f75e9ae6c95c5a8738e89ac8e73de938a167e966f3d4af-other.xml.gz
repodata/eaf07fe0b3c248c50ea0f20b8dcea24e60f2aeab0d0e182bf4176319c5347866-primary.xml.gz
repodata/repomd.xml
audit-libs-python-2.7.6-3.el7.x86_64.rpm
checkpolicy-2.5-4.el7.x86_64.rpm
container-selinux-2.42-1.gitad8f0f7.el7.noarch.rpm
container-storage-setup-0.8.0-3.git1d27ecf.el7.noarch.rpm
docker-1.13.1-53.git774336d.el7.centos.x86_64.rpm
docker-client-1.13.1-53.git774336d.el7.centos.x86_64.rpm
docker-common-1.13.1-53.git774336d.el7.centos.x86_64.rpm
libcgroup-0.41-13.el7.x86_64.rpm
libseccomp-2.3.1-3.el7.x86_64.rpm
libsemanage-python-2.5-8.el7.x86_64.rpm
oci-register-machine-0-6.git2b44233.el7.x86_64.rpm
oci-systemd-hook-0.1.15-2.gitc04483d.el7.x86_64.rpm
oci-umount-2.3.3-3.gite3c9055.el7.x86_64.rpm
policycoreutils-python-2.5-17.1.el7.x86_64.rpm
python-IPy-0.75-6.el7.noarch.rpm
setools-libs-3.3.8-1.1.el7.x86_64.rpm
skopeo-containers-0.1.28-1.git0270e56.el7.x86_64.rpm
yajl-2.0.4-4.el7.x86_64.rpm
```


http://172.16.11.235/k8s<br>

Check the server contians these files：

```bash
# centos deps
rkt-1.29.0-1.x86_64.rpm.tgz

# k8s require
etcd-v3.3.2.tgz
etcdctl-v3.3.2-linux-amd64.tgz
hyperkube-v1.9.4.tgz
kubectl-v1.9.4.tgz
registry-2.6.2.tgz
registry-data-v1.9.4.tgz
```

BAIDU DISK<br>
Link：https://pan.baidu.com/s/1UqGj5QD4zXFwoBsrCmf3XQ <br>
Pass：za7b

## 3). SSH
Store Ansible SSH Key on each CentOS Server

# Install

## 1).run ansible from docker
```cmd
docker run `
--name ansible `
-h ansible `
-v c:/git/mengkzhaoyun/ansible:/etc/ansible `
-d hub.c.163.com/mengkzhaoyun/public:ansible-2.3.0-centos7 /bin/sh -c "while true; do echo hello world; sleep 1; done"
```

## 2).enter in ansible cotainer , install etcd ..
```bash
# enter contianer run ansible scripts
docker exec -it ansible bash

# check ssh link
ssh 172.16.11.247
ssh 172.16.11.248
ssh 172.16.11.249

# exec commands to install k8s 
cd linux
ap 1.install-centos.yml -i centos
```

## 3).check rkt & etcd
```bash
# ssh 172.16.11.248
ssh 172.16.11.248

# check rkt
rkt list
UUID            APP             IMAGE NAME                                              STATE   CREATED         STARTED         NETWORKS
56703a2f        etcd            hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.2              running 2 minutes ago   2 minutes ago
c31fd758        registry        hub.c.163.com/mengkzhaoyun/k8s:registry-2.6.2           running 5 seconds ago   5 seconds ago

# check docker
docker ps

# check etcd
etcdctl cluster-health

member 5386a54d596452b is healthy: got healthy result from http://172.16.11.248:2379
member 258ce1afc19b0389 is healthy: got healthy result from http://172.16.11.247:2379
member eaa1d1b829ee4d39 is healthy: got healthy result from http://172.16.11.249:2379
cluster is healthy

# ssh exit
exit
```

## 4).install kubernetes
```bash
# run in ansible.docker
ap 2.kubernetes.yml -i centos

# ssh 172.16.11.248
ssh 172.16.11.248

# wait  k8s pod started
rkt list

UUID            APP             IMAGE NAME                                              STATE   CREATED         STARTED         NETWORKS
56703a2f        etcd            hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.2              running 8 minutes ago   8 minutes ago
6e15243e        k8s             hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.9.4         running 21 seconds ago  21 seconds ago
c31fd758        registry        hub.c.163.com/mengkzhaoyun/k8s:registry-2.6.2           running 6 minutes ago   6 minutes ago

# check in master node
kubectl get pod -n=kube-system

NAME                                    READY     STATUS    RESTARTS   AGE
kube-apiserver-172.16.11.248            1/1       Running   0          6m
kube-controller-manager-172.16.11.248   1/1       Running   0          6m
kube-scheduler-172.16.11.248            1/1       Running   0          6m

# ssh exit
exit
```

## 5).install kubernetes cni
```bash
# run in ansible.docker
ap 3.kubernetes-cni.yml -i centos

# ssh 172.16.11.248
ssh 172.16.11.248

# check in master node
kubectl get pods -n=kube-system

NAME                                           READY     STATUS    RESTARTS   AGE
kube-apiserver-172.16.11.248                   1/1       Running   0          2m
kube-controller-manager-172.16.11.248          1/1       Running   0          2m
kube-router-fmpht                              1/1       Running   0          2m
kube-router-kgfh7                              1/1       Running   0          2m
kube-router-tfhph                              1/1       Running   0          2m
kube-scheduler-172.16.11.248                   1/1       Running   0          2m
```

## 6).install kubernetes Addon
```bash
# run in ansible.docker
ap 4.kubernetes-addon.yml -i centos

# ssh 172.16.11.248
ssh 172.16.11.248

# check in master node
kubectl get pods -n=kube-system

NAME                                           READY     STATUS    RESTARTS   AGE
coredns-544d965f4d-nrfcz                       1/1       Running   0          1m
heapster-66b44cdb95-zh8nf                      4/4       Running   0          56s
kube-apiserver-172.16.11.248                   1/1       Running   0          2m
kube-controller-manager-172.16.11.248          1/1       Running   0          2m
kube-router-fmpht                              1/1       Running   0          2m
kube-router-kgfh7                              1/1       Running   0          2m
kube-router-tfhph                              1/1       Running   0          2m
kube-scheduler-172.16.11.248                   1/1       Running   0          2m
kubernetes-dashboard-688f76f6bd-ncwgx          1/1       Running   0          59s
monitoring-influxdb-grafana-7f585c6959-2vv77   2/2       Running   0          53s
```

# Brower
<img alt="Schema" src="./imgs/dashboard.png">
https://172.16.11.248:6443/ui<br>
admin <br>
abc2018