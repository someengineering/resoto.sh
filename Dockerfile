FROM docker.io/library/nginx
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/default.conf /etc/nginx/conf.d/default.conf
COPY docker/bootstrap /bootstrap
RUN apt-get update \
    && apt-get -y install \
        python3-certbot \
        python3-certbot-nginx \
        openssl \
        ca-certificates \
        cron \
        locales \
        procps \
        bash \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && rm -f /bin/sh \
    && ln -s /bin/bash /bin/sh \
    && chmod +x /bootstrap \
    && locale-gen \
    && mkdir -p /var/lib/nginx/cache \
    && chown -R nginx:nginx /var/lib/nginx/cache \
    && mkdir -p /var/spool/cron/crontabs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENTRYPOINT ["/bootstrap"]
CMD ["nginx", "-g", "daemon off;"]
