FROM nginx
LABEL "org.opencontainers.image.authors"="info@zalari.de"

# add nginx config
COPY init/default.conf /etc/nginx/conf.d/default.conf
