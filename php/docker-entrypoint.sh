#!/bin/bash -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- php-fpm "$@"
fi

if [ "$1" = 'php-fpm' ] || [ "$1" = 'bin/console' ]; then
    PHP_INI_RECOMMENDED="$PHP_INI_DIR/php.ini-production"
    if [ "$APP_ENV" != 'prod' ] && [ "$APP_ENV" != 'stage' ]; then
        PHP_INI_RECOMMENDED="$PHP_INI_DIR/php.ini-development"
    fi
    ln -sf "$PHP_INI_RECOMMENDED" "$PHP_INI_DIR/php.ini"

    #mkdir -p var/cache var/log
    #setfacl -R -m u:www-data:rwX -m u:"$(whoami)":rwX var
    #setfacl -dR -m u:www-data:rwX -m u:"$(whoami)":rwX var

    source docker-secrets.sh

    if [ "$APP_ENV" != 'prod' ] && [ "$APP_ENV" != 'stage' ]; then
        composer install --ansi --prefer-dist --no-progress --no-suggest --no-interaction
    else
        composer run-script --no-dev post-install-cmd
    fi

    # Permissions hack because setfacl does not work on Mac and Windows
    chown -R www-data var
fi

exec docker-php-entrypoint "$@"
