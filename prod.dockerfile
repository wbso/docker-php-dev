FROM wbso/php7fpm:7.3.10base

LABEL maintainer="WBSO"

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./php.ini $PHP_INI_DIR/conf.d/99-local.ini

# Opcache
# see https://secure.php.net/manual/en/opcache.installation.php
COPY config/opcache.ini $PHP_INI_DIR/conf.d/

RUN groupadd -g 1000 www && useradd -u 1000 -ms /bin/bash -g www www
USER www

# Copy composer.lock and composer.json
# COPY composer.lock composer.json /var/www/
# Run composer install

# Copy existing application directory contents
# COPY . /var/www

# Copy existing application directory permissions
# COPY --chown=www:www . /var/www

WORKDIR /var/www
CMD ["php-fpm"]
