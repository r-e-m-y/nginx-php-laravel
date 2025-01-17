#!/usr/bin/env bash
set -e

echo "Running container init script..."

php /var/www/artisan key:generate

if [ ! -f "/var/www/database/database.sqlite" ]; then
    echo "Creating SQLite database..."
    touch /var/www/database/database.sqlite
fi

echo "Init script done. Starting PHP-FPM..."

# Hand off to the CMD
exec "$@"