#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum install redis -y

chkconfig redis on

cp /etc/redis.conf{,.original}
sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis.conf 

sysctl vm.overcommit_memory=1

cat >> /etc/sysctl.conf <<EOF
# Set up for Redis
vm.overcommit_memory = 1
EOF

service redis start

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 6379 -j ACCEPT
service iptables save

