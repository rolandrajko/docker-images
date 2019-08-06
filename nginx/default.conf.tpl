server {
  listen 80;
  server_name localhost;
  root /usr/share/nginx/html;

  set $cors_origin '*';

  if ($http_origin ~ '^https?://$NGINX_ORIGIN$') {
    set $cors_origin $http_origin;
  }

  add_header Access-Control-Allow-Origin $cors_origin always;
  add_header Access-Control-Allow-Credentials 'true' always;
  add_header Access-Control-Allow-Methods 'GET, POST, PUT, PATCH, DELETE, OPTIONS' always;
  add_header Access-Control-Allow-Headers 'Accept,Authorization,Cache-Control,Content-Range,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,Range,User-Agent,X-Action,X-CustomHeader,X-Requested-With' always;
  add_header Access-Control-Expose-Headers 'Location' always;

  if ($request_method = 'OPTIONS') {
    #add_header Access-Control-Max-Age 1728000;
    #add_header Content-Type 'text/plain charset=utf-8';
    #add_header Content-Length 0;
    return 204;
  }

  location / {
    try_files $uri $NGINX_PHP_FALLBACK$is_args$args;
  }

  location = /health-check {
    #add_header Content-Type 'text/plain charset=utf-8';
    return 204;
  }

  location ~ $NGINX_PHP_LOCATION {
    fastcgi_pass $NGINX_FCGI_ADDRESS;
    fastcgi_split_path_info ^(.+\.php)(/.*)$;
    fastcgi_hide_header X-Powered-By;
    include fastcgi_params;

    #fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
    fastcgi_param SCRIPT_FILENAME $NGINX_DOC_ROOT$fastcgi_script_name;

    #fastcgi_param DOCUMENT_ROOT $realpath_root;
    fastcgi_param DOCUMENT_ROOT $NGINX_DOC_ROOT;

    # Prevents URIs that include the front controller. This will 404:
    # http://domain.tld/index.php/some-path
    # Remove the internal directive to allow URIs like this
    $NGINX_INTERNAL
  }

  location ~ \.php$ {
    return 404;
  }

  location ~ /\. {
    log_not_found off;
    access_log off;
    deny all;
  }
}
