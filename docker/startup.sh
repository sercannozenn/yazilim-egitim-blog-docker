#!/bin/sh

# Start PHP-FPM
/usr/sbin/php-fpm --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/zzz_custom.conf &

# Start Nginx
/usr/sbin/nginx -g "daemon off;"
