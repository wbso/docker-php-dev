FROM php:7.3.10-fpm

LABEL maintainer="WBSO"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    zlib1g-dev \
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
    && docker-php-ext-install bcmath iconv mbstring pdo pdo_mysql zip gd gmp mysqli calendar\
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /var/lib/apt/lists/*
