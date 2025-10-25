#!/usr/bin/env bash
set -e

echo "Running container init script..."

if [ ! -f "/var/www/database/database.sqlite" ]; then
    echo "Creating SQLite database..."
    touch /var/www/database/database.sqlite
fi

chown www-data:www-data /var/www/database/database.sqlite

echo "Run composer install"
composer install
echo "Finished composer install"

if [ ! -f "/var/www/.env" ]; then
    echo "Creating .env file from .env.example"
    cp /var/www/.env.example /var/www/.env
fi

php /var/www/artisan key:generate

echo "Build assets"
npm install
npm run build
echo "Finished building assets"

echo "Fixing storage permissions for www-data..."
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

echo "Init script done. Starting PHP-FPM..."

# Hand off to the CMD
exec "$@"