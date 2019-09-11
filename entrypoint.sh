#!/bin/bash

rm -f /var/run/docker.pid

dockerd&

runuser -l galaxy -c 'cd /galaxy ; sh run.sh'
