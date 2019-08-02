FROM php:apache
RUN apt-get update
RUN apt-get install -y \
    git \
    libpng-dev \
    libxml2-dev \
    zip
RUN docker-php-ext-install \
    gd \
    mbstring \
    pdo \
    pdo_mysql \
    xml
RUN curl --silent --show-error https://getcomposer.org/installer | php
RUN pecl install redis \
    && pecl install xdebug \
    && docker-php-ext-enable redis xdebug

# Config changes
ENV APACHE_DOCUMENT_ROOT /src/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
