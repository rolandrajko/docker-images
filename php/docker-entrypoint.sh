#!/bin/bash -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

if [ "$1" = php-fpm ] || [ "$1" = php ] || [ "$1" = bin/console ]; then
    mkdir -p var/cache var/log
	setfacl -R -m u:www-data:rwX -m u:"$(whoami)":rwX var
	setfacl -dR -m u:www-data:rwX -m u:"$(whoami)":rwX var
	
    if [ "$APP_ENV" != prod ] && [ -f composer.json ]; then
        composer install --prefer-dist --no-progress --no-suggest --no-interaction

        echo "Waiting for database to be ready..."
        until bin/console doctrine:query:sql "SELECT 1" > /dev/null 2>&1; do
            sleep 1
        done

        bin/console doctrine:schema:update --force --no-interaction
    fi

    # Permissions hack because setfacl does not work on Mac and Windows
    #chown -R www-data var
fi

exec docker-php-entrypoint "$@"
