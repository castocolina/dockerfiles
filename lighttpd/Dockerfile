FROM alpine:edge

LABEL maintainer="castocolina@gmail.com"

RUN set -x && apk update \
    && apk add lighttpd \
    && rm -rf /var/cache/apk/*

ADD htdocs /var/www/localhost/htdocs

EXPOSE 80

# CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
CMD lighttpd -version && lighttpd -D -f /etc/lighttpd/lighttpd.conf 
