#!/bin/sh

## Start PHP-FPM
#/usr/sbin/php-fpm --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/zzz_custom.conf &
#
## Start Nginx
#/usr/sbin/nginx -g "daemon off;"

sed -i "s,LISTEN_PORT,$PORT,g" /etc/nginx/nginx.conf

php-fpm -D

while ! nc -w 1 -z 127.0.0.1 9000; do sleep 0.1; done;

nginx
