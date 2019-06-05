#!/bin/bash

systemctl restart sshd

cp /etc/sudoers{,.original}

#vim /etc/sudoers <<EOF > /dev/null 2>&1
visudo <<EOF > /dev/null 2>&1
:120,120s:#includedir /etc/sudoers.d:includedir /etc/sudoers.d:
:wq
EOF

visudo -c