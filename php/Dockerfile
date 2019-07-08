FROM php:7.3-fpm

RUN sed -i \
    -e "s/^# \(export LS_OPTIONS='--color=auto'\)/\1/g" \
    -e "s/^# \(alias ls='ls \$LS_OPTIONS'\)/\1/g" \
    -e "s/^# \(alias rm='rm -i'\)/\1/g" \
    /root/.bashrc

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        acl \
        git \
        mysql-client \
        unzip \
    && rm -rf /var/lib/apt/lists/*

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        libbz2-dev \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxslt-dev \
        libzip-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        exif \
        gd \
        intl \
        pdo_mysql \
        soap \
        sockets \
        xsl \
        zip \
    && pecl install \
        apcu \
        redis \
    && pecl clear-cache \
    && docker-php-ext-enable \
        apcu \
        opcache \
        redis \
    && ln -s $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini \
    && rm -rf /var/lib/apt/lists/*

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY symfony.ini /usr/local/etc/php/conf.d/
COPY zz-www.conf /usr/local/etc/php-fpm.d/

COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-secrets.sh /usr/local/bin/

RUN mkdir -p var/cache var/log \
    && chmod +x \
        /usr/local/bin/docker-entrypoint.sh \
        /usr/local/bin/docker-secrets.sh

VOLUME /var/www/html/var

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
