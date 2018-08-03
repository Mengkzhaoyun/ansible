# debug
```powershell
# remove 
docker rm ansible -f

# docker run
docker run `
--name ansible `
-h ansible `
-v $PWD/linux/aliyun.ini:/etc/ansible/hosts `
-v $PWD/linux/group_vars/aliyun.yml:/etc/ansible/linux/group_vars/aliyun.yml `
-d hub.c.163.com/mengkzhaoyun/cloud/ansible-kubernetes

# docker exec
docker exec -it ansible bash
```