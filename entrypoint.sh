#!/bin/bash

rm -f /var/run/docker.pid

# Avoid loosing DNS resolution
cat /resolv.conf >> /etc/resolv.conf
echo "`ping -c1 db | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'` db" >> /etc/hosts

service docker start
update-rc.d docker enable

if ! crontab -l | grep -q rest-mon; then
  (crontab -l 2>/dev/null; echo \"*/5 * * * * bash /galaxy/tools/rest-mon.sh\") | crontab -
fi

runuser -l galaxy -c 'cd /galaxy ; sh run.sh'
