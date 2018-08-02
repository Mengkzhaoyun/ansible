FROM hub.c.163.com/mengkzhaoyun/public:ansible-2.3.0-centos7
MAINTAINER mengkzhaoyun <mengkzhaoyun@gmail.com>

ADD . /etc/ansible

WORKDIR /etc/ansible/linux

ENTRYPOINT tail -f /etc/ansible/hosts