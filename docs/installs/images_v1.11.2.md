# images

```powershell
# hyperkube
docker pull gcr.io/google-containers/hyperkube:v1.11.2 ;`
docker tag gcr.io/google-containers/hyperkube:v1.11.2 registry.cn-qingdao.aliyuncs.com/wod/hyperkube:v1.11.2 ;`
docker push registry.cn-qingdao.aliyuncs.com/wod/hyperkube:v1.11.2 

# kube-apiserver
docker pull gcr.io/google-containers/kube-apiserver:v1.11.2 ;`
docker tag gcr.io/google-containers/kube-apiserver:v1.11.2 registry.cn-qingdao.aliyuncs.com/wod/kube-apiserver:v1.11.2 ;`
docker push registry.cn-qingdao.aliyuncs.com/wod/kube-apiserver:v1.11.2

# kube-controller-manager
docker pull gcr.io/google-containers/kube-controller-manager:v1.11.2 ;`
docker tag gcr.io/google-containers/kube-controller-manager:v1.11.2 registry.cn-qingdao.aliyuncs.com/wod/kube-controller-manager:v1.11.2 ;`
docker push registry.cn-qingdao.aliyuncs.com/wod/kube-controller-manager:v1.11.2

# kube-scheduler
docker pull gcr.io/google-containers/kube-scheduler:v1.11.2 ;`
docker tag gcr.io/google-containers/kube-scheduler:v1.11.2 registry.cn-qingdao.aliyuncs.com/wod/kube-scheduler:v1.11.2 ;`
docker push registry.cn-qingdao.aliyuncs.com/wod/kube-scheduler:v1.11.2

# kube-proxy
docker pull gcr.io/google-containers/kube-proxy:v1.11.2 ;`
docker tag gcr.io/google-containers/kube-proxy:v1.11.2 registry.cn-qingdao.aliyuncs.com/wod/kube-proxy:v1.11.2 ;`
docker push registry.cn-qingdao.aliyuncs.com/wod/kube-proxy:v1.11.2

docker pull registry.cn-qingdao.aliyuncs.com/wod/kube-proxy:v1.11.2 ;`
docker tag registry.cn-qingdao.aliyuncs.com/wod/kube-proxy:v1.11.2 hub.c.163.com/mengkzhaoyun/k8s:kube-proxy-v1.11.2 ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:kube-proxy-v1.11.2
```