FROM nginx
MAINTAINER info@zalari.de

ENV IMAGE_VERSION=1.2-SNAPSHOT

# add nginx config
COPY init/default.conf /etc/nginx/conf.d/default.conf

# update and install jq
RUN apt-get update
RUN apt-get -y install jq

# make jsonenv globally available
COPY init/jsonenv.sh /bin/jsonenv
RUN chmod 755 /bin/jsonenv

# copy start script and set permissions
COPY ./docker-command.sh /etc/init.d/
RUN chmod 744 /etc/init.d/docker-command.sh

# run command on start
CMD ["/bin/bash", "/etc/init.d/docker-command.sh"]