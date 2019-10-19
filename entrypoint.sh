#!/bin/bash

rm -f /var/run/docker.pid

# Avoid loosing DNS resolution
cat /resolv.conf >> /etc/resolv.conf
echo "`ping -c1 db | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'` db" >> /etc/hosts

systemctl start docker
systemctl enable docker


runuser -l galaxy -c 'cd /galaxy ; sh run.sh'
