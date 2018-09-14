#!/bin/bash

# write env variables to config.json
jsonenv SW /usr/share/nginx/html/config.json

# start nginx
# s. https://goo.gl/wiDNWV
nginx -g "daemon off;"
