#!/bin/bash

rm -f /var/run/docker.pid

cat /resolv.conf >> /etc/resolv.conf

dockerd&

runuser -l galaxy -c 'cd /galaxy ; sh run.sh'
