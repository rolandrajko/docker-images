FROM nginx:1.20-alpine

COPY default.conf.tpl /etc/nginx/conf.d/
COPY nginx.conf.tpl /etc/nginx/
COPY docker-entrypoint.sh /usr/local/bin/

RUN apk add --no-cache bash \
    && chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
