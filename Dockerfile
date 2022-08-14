FROM php:7.4-apache as production

RUN apt-get update && apt-get install -y \
    git curl cron supervisor libjpeg-dev libpng-dev libonig-dev \
    libfreetype6-dev libjpeg62-turbo-dev libgd-dev jpegoptim optipng pngquant gifsicle \
    libxml2-dev zip unzip libzip-dev libxml2-dev \
    libmcrypt-dev openssl libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick

RUN docker-php-ext-configure opcache --enable-opcache
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd mbstring mysqli pdo pdo_mysql shmop opcache iconv soap exif zip bcmath

RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis
