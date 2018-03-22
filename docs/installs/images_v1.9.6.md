# registry
docker pull registry:2.6.2 &&\
docker tag registry:2.6.2 hub.c.163.com/mengkzhaoyun/k8s:registry-2.6.2 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:registry-2.6.2

# etcd
docker pull quay.io/coreos/etcd:v3.3.2 &&\
docker tag quay.io/coreos/etcd:v3.3.2 hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.2 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.2

# pause
docker pull gcr.io/google_containers/pause:3.1 &&\
docker tag gcr.io/google_containers/pause:3.1 hub.c.163.com/mengkzhaoyun/k8s:pause-3.1 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:pause-3.1

# hyperkube
docker pull gcr.io/google_containers/hyperkube:v1.9.6 &&\
docker tag gcr.io/google_containers/hyperkube:v1.9.6 hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.9.6 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.9.6 

# flannel
docker pull quay.io/coreos/flannel:v0.10.0 &&\
docker tag quay.io/coreos/flannel:v0.10.0 hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0

# kube-router
docker pull cloudnativelabs/kube-router:v0.1.0 &&\
docker tag cloudnativelabs/kube-router:v0.1.0 hub.c.163.com/mengkzhaoyun/k8s:kube-router-v0.1.0 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:kube-router-v0.1.0

# busybox
docker pull gcr.io/google_containers/busybox:1.27.2 &&\
docker tag gcr.io/google_containers/busybox:1.27.2 hub.c.163.com/mengkzhaoyun/k8s:busybox-1.27.2 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:busybox-1.27.2 

# coredns
docker pull coredns/coredns:1.1.0 &&\
docker tag coredns/coredns:1.1.0 hub.c.163.com/mengkzhaoyun/k8s:coredns-1.1.0 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:coredns-1.1.0

# dashboard
docker pull gcr.io/google_containers/kubernetes-dashboard-amd64:v1.8.3 &&\
docker tag gcr.io/google_containers/kubernetes-dashboard-amd64:v1.8.3 hub.c.163.com/mengkzhaoyun/k8s:kubernetes-dashboard-amd64-v1.8.3 &&\
docker push hub.c.163.com/mengkzhaoyun/k8s:kubernetes-dashboard-amd64-v1.8.3 