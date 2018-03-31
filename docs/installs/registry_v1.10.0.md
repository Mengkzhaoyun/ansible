# Get Registry Data

registry-data-v1.10.0.tgz

```bash
# run registry
docker run -d -p 5000:5000 -v /data:/var/lib/registry --name registry hub.c.163.com/mengkzhaoyun/public:registry-2.6.2 

# hyperkube-v1.10.0
docker pull hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.10.0 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.10.0 localhost:5000/k8s/hyperkube:v1.10.0 &&\
docker push localhost:5000/k8s/hyperkube:v1.10.0

# pause:3.1
docker pull hub.c.163.com/mengkzhaoyun/k8s:pause-3.1 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:pause-3.1 localhost:5000/k8s/pause:3.1 &&\
docker push localhost:5000/k8s/pause:3.1

# kube-router:v0.1.0
docker pull hub.c.163.com/mengkzhaoyun/k8s:kube-router-v0.1.0 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:kube-router-v0.1.0 localhost:5000/k8s/kube-router:v0.1.0 &&\
docker push localhost:5000/k8s/kube-router:v0.1.0

# kube-proxy:v1.10.0
docker pull hub.c.163.com/mengkzhaoyun/k8s:kube-proxy-v1.10.0 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:kube-proxy-v1.10.0 localhost:5000/k8s/kube-proxy:v1.10.0 &&\
docker push localhost:5000/k8s/kube-proxy:v1.10.0

# flannel:v0.10.0
docker pull hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0 localhost:5000/k8s/flannel:v0.10.0 &&\
docker push localhost:5000/k8s/flannel:v0.10.0

# busybox:1.27.2
docker pull hub.c.163.com/mengkzhaoyun/k8s:busybox-1.27.2 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:busybox-1.27.2 localhost:5000/k8s/busybox:1.27.2 &&\
docker push localhost:5000/k8s/busybox:1.27.2

# coredns:1.1.1
docker pull hub.c.163.com/mengkzhaoyun/k8s:coredns-1.1.1 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:coredns-1.1.1 localhost:5000/k8s/coredns:1.1.1 &&\
docker push localhost:5000/k8s/coredns:1.1.1

# kubernetes-dashboard-amd64:v1.8.3
docker pull hub.c.163.com/mengkzhaoyun/k8s:kubernetes-dashboard-amd64-v1.8.3 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:kubernetes-dashboard-amd64-v1.8.3 localhost:5000/k8s/kubernetes-dashboard-amd64:v1.8.3 &&\
docker push localhost:5000/k8s/kubernetes-dashboard-amd64:v1.8.3

# heapster-amd64:v1.5.2
docker pull hub.c.163.com/mengkzhaoyun/k8s:heapster-amd64-v1.5.2 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:heapster-amd64-v1.5.2 localhost:5000/k8s/heapster-amd64:v1.5.2 &&\
docker push localhost:5000/k8s/heapster-amd64:v1.5.2

# addon-resizer:1.8.1
docker pull hub.c.163.com/mengkzhaoyun/k8s:addon-resizer-1.8.1 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:addon-resizer-1.8.1 localhost:5000/k8s/addon-resizer:1.8.1 &&\
docker push localhost:5000/k8s/addon-resizer:1.8.1

# heapster-influxdb-amd64:v1.3.3
docker pull hub.c.163.com/mengkzhaoyun/k8s:heapster-influxdb-amd64-v1.3.3 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:heapster-influxdb-amd64-v1.3.3 localhost:5000/k8s/heapster-influxdb-amd64:v1.3.3 &&\
docker push localhost:5000/k8s/heapster-influxdb-amd64:v1.3.3

# heapster-grafana-amd64:v4.4.3
docker pull hub.c.163.com/mengkzhaoyun/k8s:heapster-grafana-amd64-v4.4.3 &&\
docker tag hub.c.163.com/mengkzhaoyun/k8s:heapster-grafana-amd64-v4.4.3 localhost:5000/k8s/heapster-grafana-amd64:v4.4.3 &&\
docker push localhost:5000/k8s/heapster-grafana-amd64:v4.4.3
```