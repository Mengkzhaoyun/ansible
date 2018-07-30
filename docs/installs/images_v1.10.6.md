# images

```powershell
# registry
docker pull registry:2.6.2 ;`
docker tag registry:2.6.2 hub.c.163.com/mengkzhaoyun/k8s:registry-2.6.2 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:registry-2.6.2

# etcd
docker pull quay.io/coreos/etcd:v3.3.9 ;`
docker tag quay.io/coreos/etcd:v3.3.9 hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.9 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.9

# pause
docker pull k8s.gcr.io/pause:3.1 ;`
docker tag k8s.gcr.io/pause:3.1 hub.c.163.com/mengkzhaoyun/k8s:pause-3.1 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:pause-3.1

# hyperkube
docker pull k8s.gcr.io/hyperkube:v1.10.6 ;`
docker tag k8s.gcr.io/hyperkube:v1.10.6 hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.10.6 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.10.6 

# flannel
docker pull quay.io/coreos/flannel:v0.10.0 ;`
docker tag quay.io/coreos/flannel:v0.10.0 hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0

# kube-router
docker pull cloudnativelabs/kube-router:v0.2.0-beta.9 ;`
docker tag cloudnativelabs/kube-router:v0.2.0-beta.9 hub.c.163.com/mengkzhaoyun/k8s:kube-router-v0.2.0-beta.9 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:kube-router-v0.2.0-beta.9

# busybox
docker pull k8s.gcr.io/busybox:1.27.2 ;`
docker tag k8s.gcr.io/busybox:1.27.2 hub.c.163.com/mengkzhaoyun/k8s:busybox-1.27.2 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:busybox-1.27.2

# coredns
docker pull coredns/coredns:1.2.0 ;`
docker tag coredns/coredns:1.2.0 hub.c.163.com/mengkzhaoyun/k8s:coredns-1.2.0 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:coredns-1.2.0

# dashboard
docker pull k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3 ;`
docker tag k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3 hub.c.163.com/mengkzhaoyun/k8s:kubernetes-dashboard-amd64-v1.8.3 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:kubernetes-dashboard-amd64-v1.8.3 

# heapster-amd64
docker pull k8s.gcr.io/heapster-amd64:v1.5.4 ;`
docker tag k8s.gcr.io/heapster-amd64:v1.5.4 hub.c.163.com/mengkzhaoyun/k8s:heapster-amd64-v1.5.4 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:heapster-amd64-v1.5.4

# addon-resizer
docker pull k8s.gcr.io/addon-resizer:1.8.3 ;`
docker tag k8s.gcr.io/addon-resizer:1.8.3 hub.c.163.com/mengkzhaoyun/k8s:addon-resizer-1.8.3 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:addon-resizer-1.8.3

# heapster-influxdb-amd64
docker pull k8s.gcr.io/heapster-influxdb-amd64:v1.5.2 ;`
docker tag k8s.gcr.io/heapster-influxdb-amd64:v1.5.2 hub.c.163.com/mengkzhaoyun/k8s:heapster-influxdb-amd64-v1.5.2 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:heapster-influxdb-amd64-v1.5.2

# heapster-grafana-amd64
docker pull k8s.gcr.io/heapster-grafana-amd64:v5.0.4 ;`
docker tag k8s.gcr.io/heapster-grafana-amd64:v5.0.4 hub.c.163.com/mengkzhaoyun/k8s:heapster-grafana-amd64-v5.0.4 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:heapster-grafana-amd64-v5.0.4
```