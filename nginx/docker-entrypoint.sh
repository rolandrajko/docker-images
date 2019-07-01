#!/bin/bash -e

################################################################
# Configure NGINX
################################################################
export NGINX_CIDR=${NGINX_CIDR:-'10.0.0.0/8'}
export NGINX_DOC_ROOT=${NGINX_DOC_ROOT:-'/var/www/html/public'}
export NGINX_FCGI_ADDRESS=${NGINX_FCGI_ADDRESS:-'php:9000'}
export NGINX_INTERNAL=${NGINX_INTERNAL:-'internal;'}
export NGINX_ORIGIN=${NGINX_ORIGIN:-'localhost'}
export NGINX_PHP_FALLBACK=${NGINX_PHP_FALLBACK:-'/index.php'}
export NGINX_PHP_LOCATION=${NGINX_PHP_LOCATION:-'^/index\.php(/|$)'}

envsubst '${NGINX_CIDR}' \
    < /etc/nginx/nginx.conf.tpl > /etc/nginx/nginx.conf

envsubst '${NGINX_DOC_ROOT} ${NGINX_FCGI_ADDRESS} ${NGINX_INTERNAL} ${NGINX_ORIGIN} ${NGINX_PHP_FALLBACK} ${NGINX_PHP_LOCATION}' \
    < /etc/nginx/conf.d/default.conf.tpl > /etc/nginx/conf.d/default.conf

################################################################
# Exec CMD
################################################################
exec "$@"
