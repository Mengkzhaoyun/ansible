# Deploy

<img alt="Schema" src="./imgs/ubuntu-schema.png">

Online Vedio<br>
https://www.bilibili.com/video/av20150387/<br>
https://www.youtube.com/watch?v=144Ng2D5jxQ


# Prepare

## 1). Config
Modify Machine Name&IP<br>
./hosts

Modify k8s Cluster Config<br>
./linux/group_vars/systech

## 2). HTTP_SERVER
http://172.16.11.235/k8s<br>
Check the server contians these files：
```bash
# ubuntu deps
libltdl7_2.4.6-0.1_amd64.tgz
iptables_1.6.0-2ubuntu3_amd64.tgz
docker-engine_1.13.1-0~ubuntu-xenial_amd64.tgz
rkt_1.29.0-1_amd64.tgz

# k8s require
etcd-v3.3.1.tgz
etcdctl-v3.3.1-linux-amd64.tgz
flannel-v0.9.1.tgz
hyperkube-v1.9.3.tgz
kubectl-v1.9.3.tgz
registry-2.6.2.tgz
registry-data-v1.9.3.tgz
```

BAIDU DISK<br>
Link：https://pan.baidu.com/s/1c3J0IZm <br>
Pass：nbk7

## 3). SSH
Store Ansible SSH Key on each Ubuntu Server

# Install

## 1).run ansible from docker
```cmd
docker run `
--name ansible `
-h ansible `
-v c:/git/github.com/ansible/:/etc/ansible `
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
ap 0.bootstrap.yml
ap 1.install.yml
```

## 3).check rkt & etcd
```bash
# ssh 172.16.11.248
ssh 172.16.11.248

# check rkt
rkt list
UUID            APP             IMAGE NAME                                              STATE   CREATED         STARTED         NETWORKS
56703a2f        etcd            hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.1              running 2 minutes ago   2 minutes ago
5686972d        flannelopts     hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.9.1           exited  1 minute ago    1 minute ago
7abe579f        flannel         hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.9.1           running 1 minute ago    1 minute ago
c31fd758        registry        hub.c.163.com/mengkzhaoyun/public:registry-2.6.2        running 5 seconds ago   5 seconds ago

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
ap 2.kubernetes.yml

# ssh 172.16.11.248
ssh 172.16.11.248

# wait  k8s pod started
rkt list
UUID            APP             IMAGE NAME                                              STATE   CREATED         STARTED         NETWORKS
56703a2f        etcd            hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.1              running 8 minutes ago   8 minutes ago
5686972d        flannelopts     hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.9.1           exited  8 minutes ago   8 minutes ago
6e15243e        k8s             hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.9.3         running 21 seconds ago  21 seconds ago
7abe579f        flannel         hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.9.1           running 8 minutes ago   8 minutes ago
c31fd758        registry        hub.c.163.com/mengkzhaoyun/public:registry-2.6.2        running 6 minutes ago   6 minutes ago

# check in master node
kubectl get pod -n=kube-system

NAME                                    READY     STATUS    RESTARTS   AGE
kube-apiserver-172.16.11.248            1/1       Running   0          6m
kube-controller-manager-172.16.11.248   1/1       Running   0          6m
kube-proxy-172.16.11.247                1/1       Running   0          24s
kube-proxy-172.16.11.248                1/1       Running   0          6m
kube-proxy-172.16.11.249                1/1       Running   0          7m
kube-scheduler-172.16.11.248            1/1       Running   0          6m

# ssh exit
exit
```

## 5).install kubernetes Addon
```bash
# run in ansible.docker
ap 3.kubernetes-addon.yml

# ssh 172.16.11.248
ssh 172.16.11.248

# check in master node
kubectl get pods -n=kube-system
NAME                                           READY     STATUS    RESTARTS   AGE
coredns-544d965f4d-nrfcz                       1/1       Running   0          1m
heapster-66b44cdb95-zh8nf                      4/4       Running   0          56s
kube-apiserver-172.16.11.248                   1/1       Running   0          2m
kube-controller-manager-172.16.11.248          1/1       Running   0          2m
kube-proxy-172.16.11.247                       1/1       Running   0          2m
kube-proxy-172.16.11.248                       1/1       Running   0          2m
kube-proxy-172.16.11.249                       1/1       Running   0          2m
kube-scheduler-172.16.11.248                   1/1       Running   0          2m
kubernetes-dashboard-688f76f6bd-ncwgx          1/1       Running   0          59s
monitoring-influxdb-grafana-7f585c6959-2vv77   2/2       Running   0          53s
```

# Brower
<img alt="Schema" src="./imgs/dashboard.png">
https://172.16.11.248:6443/ui<br>
admin <br>
abc2018
