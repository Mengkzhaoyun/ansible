# How to Create Install Datas

## 1.10.0
BAIDU DISK <br>
Link：https://pan.baidu.com/s/1J77VDcOoUiIWM8qZRYghvA <br>
Pass：7je9

## Get Images

[images.md](./docs/installs/images_v1.10.0.md)
```bash
# registry
docker pull registry:2.6.2

# etcd
docker pull quay.io/coreos/etcd:v3.3.2

# pause
docker pull k8s.gcr.io/pause:3.1

# hyperkube
docker pull k8s.gcr.io/hyperkube:v1.10.0

# flannel
docker pull quay.io/coreos/flannel:v0.10.0

# kube-router
docker pull cloudnativelabs/kube-router:v0.1.0

# busybox
docker pull k8s.gcr.io/busybox:1.27.2

# coredns
docker pull coredns/coredns:1.1.1

# dashboard
docker pull k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3

# heapster
docker pull k8s.gcr.io/heapster-amd64:v1.5.2

# addon-resizer
docker pull k8s.gcr.io/addon-resizer:1.8.1

# heapster-influxdb-amd64
docker pull k8s.gcr.io/heapster-influxdb-amd64:v1.3.3

# heapster-grafana-amd64
docker pull k8s.gcr.io/heapster-grafana-amd64:v4.4.3
```

## Get ACI Image

[aci.md](./docs/installs/aci_v1.10.0.md)

```bash
rkt image export hub.c.163.com/mengkzhaoyun/public:registry-2.6.2 registry-2.6.2.aci

rkt image export hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.2 etcd-v3.3.2.aci

rkt image export hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0 flannel-v0.10.0.aci

rkt image export hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.10.0 hyperkube-v1.10.0.aci
```

## Get CTL

[ctl.md](./docs/installs/ctl_v1.10.0.md)

```bash
# ct
https://github.com/coreos/container-linux-config-transpiler/releases/download/v0.4.2/ct-v0.4.2-x86_64-unknown-linux-gnu

# kubectl
kubectl-v1.10.0.tgz
https://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/linux/amd64/kubectl

# etcdctl
etcd-v3.3.2-linux-amd64.tgz
https://github.com/coreos/etcd/releases/download/v3.3.2/etcd-v3.3.2-linux-amd64.tar.gz
```

## Get Registry Data

[registry.md](./docs/installs/registry_v1.10.0.md)