FROM yobasystems/alpine-mariadb:11.4.9

RUN apk add --update --no-cache tzdata \
    && cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime \
    && echo "Europe/Amsterdam" > /etc/timezone \
    && apk del tzdata \
    ;

COPY my.cnf /etc/my.cnf.d/10-overrides.cnf