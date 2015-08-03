FROM alpine:edge

WORKDIR /usr/src/app
COPY composer.json /usr/src/app/
COPY composer.lock /usr/src/app/

RUN apk --update add git php-common php-xml php-dom php-ctype php-iconv php-json php-phar php-openssl curl && \
    curl -sS https://getcomposer.org/installer | php && \
    /usr/src/app/composer.phar install && \
    apk del build-base && rm -fr /usr/share/ri

RUN adduser -u 9000 -D app
USER app

COPY . /usr/src/app

CMD ["/usr/src/app/bin/codeclimate-phpmd"]
