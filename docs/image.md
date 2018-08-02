# run docker container
```powershell
# 下载源代码
mkdir -p c:/go/src/github.com/mengkzhaoyun
cd c:/go/src/github.com/mengkzhaoyun
git clone git@github.com:Mengkzhaoyun/ansible.git

# 进入源代码目录
cd c:/go/src/github.com/mengkzhaoyun/ansible

# 运行ansible容器
docker run `
--name ansible `
-h ansible `
-v $PWD/hosts:/etc/ansible/hosts `
-v $PWD/linux/group_vars/systech.yml:/etc/ansible/linux/group_vars/systech.yml `
-d hub.c.163.com/mengkzhaoyun/cloud/ansible-kubernetes

# 进入ansible容器
docker exec -it ansible bash

# 安装k8s集群
ap 1.install.yml

# 卸载k8s集群
ap 9.uninstall.yml
```

# build own image
```powershell
# 进入源代码目录
cd c:/go/src/github.com/mengkzhaoyun/ansible

# 构建镜像
docker build `
-f ./build/dockerfile `
-t hub.c.163.com/mengkzhaoyun/cloud/ansible-kubernetes:v1.10.6 .

# 推送镜像
docker push hub.c.163.com/mengkzhaoyun/cloud/ansible-kubernetes:v1.10.6

# 更新latest
docker tag `
hub.c.163.com/mengkzhaoyun/cloud/ansible-kubernetes:v1.10.6 `
hub.c.163.com/mengkzhaoyun/cloud/ansible-kubernetes:latest ;`
docker push `
hub.c.163.com/mengkzhaoyun/cloud/ansible-kubernetes:latest
```