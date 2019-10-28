FROM nginx
LABEL "org.opencontainers.image.authors"="info@zalari.de"
LABEL "org.opencontainers.image.version"="2.0"

# add nginx config
COPY init/default.conf /etc/nginx/conf.d/default.conf
