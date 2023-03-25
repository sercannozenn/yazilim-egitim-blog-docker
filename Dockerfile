# Base image
FROM php:8.1-fpm-alpine

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apk update && apk add --no-cache \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libzip-dev \
    supervisor \
    nginx

# Install PHP extensions
RUN docker-php-ext-install \
    bcmath \
    exif \
    gd \
    mysqli \
    opcache \
    pdo_mysql \
    zip

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the application files to the container
COPY . .

# Switch to www-data user
USER www-data

# Install the application dependencies
RUN composer install --no-dev --prefer-dist --no-interaction

# Copy the nginx configuration file
COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf

# Copy the supervisord configuration file
COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy the startup script
COPY ./docker/startup.sh /usr/local/bin/startup.sh

# Give execution permission to the startup script
RUN chmod +x /usr/local/bin/startup.sh

# Give permission to www-data user
RUN chown -R www-data:www-data /var/www/html

# Copy the php-fpm configuration file
COPY ./docker/php-fpm.conf /usr/local/etc/php-fpm.d/zzz_custom.conf

# Expose ports 80 and 443
EXPOSE 80
EXPOSE 443

# Run the startup script
#CMD sh ./docker/startup.sh

CMD ["startup.sh"]
