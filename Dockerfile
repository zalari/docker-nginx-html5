FROM nginx

ENV IMAGE_VERSION=1.1

COPY init/default.conf /etc/nginx/conf.d/default.conf

RUN apt-get update
RUN apt-get -y install jq

COPY init/jsonenv.sh /bin/jsonenv