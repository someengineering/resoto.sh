FROM docker.io/library/nginx
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/default.conf /etc/nginx/conf.d/default.conf
RUN mkdir -p /var/lib/nginx/cache \
    && chown -R nginx:nginx /var/lib/nginx/cache
