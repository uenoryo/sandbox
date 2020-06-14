FROM phusion/baseimage:latest

RUN apt-get install -y software-properties-common && \
add-apt-repository -y ppa:ondrej/php

RUN apt-get update && \
apt-get install -y --allow-downgrades --allow-remove-essential \
--allow-change-held-packages \
php7.2-cli \
php7.2-common \
php7.2-curl \
php7.2-intl \
php7.2-json \
php7.2-xml \
php7.2-mbstring \
php7.2-mysql \
php7.2-redis \
php7.2-zip \
php7.2-gd \
php7.2-dev \
pkg-config \
git \
curl \
vim \
nginx \
&& apt-get clean

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
mv composer.phar /usr/local/bin/composer
