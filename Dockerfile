FROM php:apache

# Omeka-S web publishing platform for digital heritage collections (https://omeka.org/s/)
MAINTAINER QUT eResearch <eresearch@qut.edu.au>

RUN a2enmod rewrite

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update && apt-get -qq -y upgrade
RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    libmemcached-dev \
    zlib1g-dev \
    imagemagick \
    libmagickwand-dev

# Install the PHP extensions we need
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install -j$(nproc) iconv pdo pdo_mysql mysqli gd
RUN pecl install imagick && docker-php-ext-enable imagick

RUN curl -J -L -s -k \
    'https://github.com/omeka/omeka-s/releases/download/v4.0.4/omeka-s-4.0.4.zip' \
    -o /var/www/omeka-s.zip \
&&  unzip -q /var/www/omeka-s.zip -d /var/www/ \
&&  rm /var/www/omeka-s.zip \
&&  rm -rf /var/www/html \
&&  mv /var/www/omeka-s /var/www/html \
&&  chown -R www-data:www-data /var/www/html

COPY ./database.ini /var/www/html/config/database.ini
COPY ./imagemagick-policy.xml /etc/ImageMagick/policy.xml
COPY ./.htaccess /var/www/html/.htaccess

VOLUME /var/www/html

CMD ["apache2-foreground"]