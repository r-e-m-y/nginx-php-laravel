# Start with PHP 8.4 FPM (FastCGI Process Manager)
FROM php:8.4-fpm

# Accept the uid build argument
ARG uid

# Change www-data's user and group ID to match the host user
RUN if [ -n "$uid" ]; then \
    echo "Changing www-data UID to $uid"; \
    groupmod -o -g $uid www-data; \
    usermod -o -u $uid -g $uid www-data; \
fi

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    zip \
    unzip \
    nodejs \
    npm

# Clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
# Each one serves specific purpose:
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    intl \
    zip \
    opcache

# Redis for caching/sessions
RUN pecl install redis && docker-php-ext-enable redis

RUN if [ "$XDEBUG_ENABLED" = "1" ]; then pecl install xdebug \
    && docker-php-ext-enable xdebug; \
fi

# Get Composer (PHP package manager)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Add our PHP config
COPY ./docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini

# Set working directory
WORKDIR /var/www

# Create alias
RUN echo "alias artisan='php /var/www/artisan'" >> ~/.bashrc
RUN echo "alias test='php /var/www/artisan test'" >> ~/.bashrc
RUN echo "alias pint='/var/www/vendor/bin/pint'" >> ~/.bashrc
RUN echo "alias phpstan='/var/www/vendor/bin/phpstan analyse --memory-limit=2G'" >> ~/.bashrc

COPY ./docker/php/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]