FROM nginx

ENV IMAGE_VERSION=1.0

COPY init/default.conf /etc/nginx/conf.d/default.conf

RUN apt-get update
RUN apt-get -y install jq

COPY init/dumpenv.sh /bin/dumpenv