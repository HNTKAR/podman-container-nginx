#!/bin/bash

mkdir -p /V/{cert,conf,logs,sites}
cp -rf /usr/local/share/sites/* /V/sites/
chown -R $(id -u nginx):$(id -u nginx) /V/{cert,conf,logs,sites}
chmod -R 777 /V/{cert,conf,logs,sites}

cp -rn /usr/local/share/cert/* /V/cert/

touch /usr/local/bin/additional.sh
chmod +x /usr/local/bin/additional.sh
source /usr/local/bin/additional.sh

touch /V/logs/access.log /V/logs/error.log /V/conf/nginx.conf
tail -F /V/logs/error.log &
tail -F /V/logs/access.log &

exec nginx -c /etc/nginx/nginx-user.conf -g 'daemon off;'
