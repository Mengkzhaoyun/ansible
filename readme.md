# One Command Auto Deploy kubernetes cluster

## What the scripts do ?

- One Command Deploy a kubernetes cluster<br>
- One Command Add a node to cluster<br>

## Support OS

- CentOS 7.4 (Core)<br>
- Ubuntu 16.04 LTS<br>
- CoreOS Latest<br>

## Install Version

- cotainer engine: docker 1.13.1<br>
- etcd: v3.3.9<br>
- kubernetes: v1.10.6<br>
- kubernetes-network: flannel:v0.10.0<br>
- kubernetes-addons: coredns:1.2.0 , dashboard:v1.8.3 , heapster:v1.5.4

## Start it ?

### 1.Setup Hosts
make sure you had setup ansible ssh key to each node<br>
/root/.ssh/authorized_keys
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDCJNFRbNc0SsHa/+mWB71z7SLPH9rQpwEqGbRo7q466a97h3bejNav9wc9AKmepHPfRw7DJfSmWO3lGBya0QkXMYXVvtfcWPvZZDlar5JK/ZsC8HGOpwVLdd1uUfyPu2qM0sjRNA/Ty8PDMkS5dSyZAJNlxUAILRpepkYoT8jhrw== ansible@space.docker
```

define the cluster in hosts<br>
- systech14
- systech15
- systech16
<br>

[./hosts](./hosts)
```ini
[systech]
systech14 ansible_ssh_host=172.16.11.244 ansible_ssh_port=22 ansible_ssh_user=root 
systech15 ansible_ssh_host=172.16.11.245 ansible_ssh_port=22 ansible_ssh_user=root 
systech16 ansible_ssh_host=172.16.11.246 ansible_ssh_port=22 ansible_ssh_user=root 
; systech17 ansible_ssh_host=172.16.11.247 ansible_ssh_port=22 ansible_ssh_user=root  
; systech18 ansible_ssh_host=172.16.11.248 ansible_ssh_port=22 ansible_ssh_user=root 
; systech19 ansible_ssh_host=172.16.11.249 ansible_ssh_port=22 ansible_ssh_user=root
```

### 2.Define Master
define the master in vals<br>
systech14 is the master<br>
[./linux/group_vars/systech.yml](./linux/group_vars/systech.yml)
```yml
# system options
SSH_INSTALL_KEYS: 
  - ansible
  - admin

# registry options
REGISTRY_LOCAL_HOSTNAME: systech14
REGISTRY_LOCAL_IP: "{{ hostvars['systech14']['ansible_default_ipv4']['address'] }}"

# etcd options
ETCD_CLUSTER: 
  - systech14

ETCD_CLUSTER_ROLE: 
  systech14: etcd

# k8s option
K8S_CLUSTER_ROLE: 
  systech14: master

K8S_MASTER_IP: "{{ hostvars['systech14']['ansible_default_ipv4']['address'] }}"
```

### 3.Install
docker run <br>
```powershell
# docker run
docker run `
--name ansible `
-h ansible `
-v $PWD/hosts:/etc/ansible/hosts `
-v $PWD/linux/group_vars/systech.yml:/etc/ansible/linux/group_vars/systech.yml `
-d hub.c.163.com/mengkzhaoyun/cloud/ansible-kubernetes

# docker exec
docker exec -it ansible bash

# install kubernetes cluster
ap 1.install.yml

# uninstall kubernetes cluster
ap 9.uninstall.yml
```

### 4.Open Browser
https://172.16.11.244:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#<br>
admin<br>
abc2018
