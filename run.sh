#!/bin/bash

touch /var/log/nginx/access.log /var/log/nginx/error.log
tail -F /var/log/nginx/access.log &
tail -F /var/log/nginx/error.log &

exec nginx -c /etc/nginx/nginx-user.conf -g 'daemon off;'
