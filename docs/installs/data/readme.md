# build
```powershell
# etcdctl
cd C:\Go\src\github.com\mengkzhaoyun\ansible\docs\installs\data ;`
docker build -f etcdctl.dockerfile -t hub.c.163.com/mengkzhaoyun/k8s:etcdctl-latest . ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:etcdctl-latest

# kubectl
cd C:\Go\src\github.com\mengkzhaoyun\ansible\docs\installs\data ;`
docker build -f kubectl.dockerfile -t hub.c.163.com/mengkzhaoyun/k8s:kubectl-latest . ;`
docker push hub.c.163.com/mengkzhaoyun/k8s:kubectl-latest
```