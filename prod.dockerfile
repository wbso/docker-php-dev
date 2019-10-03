FROM php:7.3.10-fpm

LABEL maintainer="WBSO"

RUN apt-get update \
    && apt-get install -y --no-install-recommends zlib1g-dev \
    git \
    libgmp-dev \
    unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    build-essential \
    chrpath \
    libssl-dev \
    libxft-dev \
    libfreetype6 \
    libfontconfig1 \
    libfontconfig1-dev \
    libzip-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure gmp \
    && docker-php-ext-install bcmath opcache iconv mbstring pdo pdo_mysql zip gd gmp mysqli calendar\
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /var/lib/apt/lists/*

# Use the default production configuration
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./php.ini $PHP_INI_DIR/conf.d/99-local.ini

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=60'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

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
