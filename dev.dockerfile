FROM wbso/php7fpm:7.3.10base

LABEL maintainer="WBSO"

RUN pecl install xdebug-2.7.2 \
    && docker-php-ext-enable xdebug

RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www
USER www
WORKDIR /var/www
CMD ["php-fpm"]
