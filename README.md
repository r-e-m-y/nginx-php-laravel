### Base for laravel with docker, mariaDB and nginx

1. Change the `docker-compose.yml` to set the correct database and network
2. Add a `docker-compose.override.yml` file to enable xDebug:

    ```yml
    services:
      php:
        build:
          args:
            XDEBUG_ENABLED: 1
        ports:
          - "5173:5173"
    ```

3. Change the `.env.example` to set the correct database and network
4. Run `docker-compose up --build -d` to start the containers
5. Run `docker compose exec -it php bash` followed by `artisan migrate` to run the basic migrations

### Development
1. To start the frontend asset: `docker compose exec -it php bash npm run dev`

### This boilerplate comes with:
- Laravel 13
- PHP 8.3
- MariaDB 10.11
- Nginx 1.25
- NodeJS 18
- Tailwind
- Mailpit (for email testing)