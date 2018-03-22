rkt image export hub.c.163.com/mengkzhaoyun/public:registry-2.6.2 registry-2.6.2.aci

rkt image export hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.2 etcd-v3.3.2.aci

rkt image export hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0 flannel-v0.10.0.aci

# hyperkube
``` shell
cd /etc/kubernetes/downloads && \
rkt fetch docker://hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.9.6 --insecure-options=image && \
rkt image export hub.c.163.com/mengkzhaoyun/k8s:hyperkube-v1.9.6 hyperkube-v1.9.6.aci
```

# flannel
``` shell
cd /etc/kubernetes/downloads && \
rkt fetch docker://hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0 --insecure-options=image && \
rkt image export hub.c.163.com/mengkzhaoyun/k8s:flannel-v0.10.0 flannel-v0.10.0.aci
```

# etcd
``` shell
cd /etc/kubernetes/downloads && \
rkt fetch docker://hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.2 --insecure-options=image && \
rkt image export hub.c.163.com/mengkzhaoyun/k8s:etcd-v3.3.2 etcd-v3.3.2.aci
```

# registry
``` shell
cd /etc/kubernetes/downloads && \
rkt fetch docker://hub.c.163.com/mengkzhaoyun/k8s:registry-2.6.2 --insecure-options=image && \
rkt image export hub.c.163.com/mengkzhaoyun/k8s:registry-2.6.2 registry-2.6.2.aci
```