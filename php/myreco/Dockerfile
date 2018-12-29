FROM laradock/workspace:2.2-7.2

USER root

# PHP REDIS EXTENSION
RUN printf "\n" | pecl -q install -o -f redis && \
    echo "extension=redis.so" >> /etc/php/7.2/mods-available/redis.ini && \
    phpenmod redis

RUN apt-get update && apt-get install -y apache2

# Set default work directory
WORKDIR /var/www
