#!/bin/sh

set -e

# this script is tailored to be used in an AWS ec2 instance as a crontab task on a root level.
# edit, copy and paste file into an upper level folder from this repo's folder.
cd /home/ec2-user/django-ssl
/usr/local/bin/docker-compose -f docker-compose.deploy.yml run --rm certbot certbot renew