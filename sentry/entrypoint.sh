#!/bin/bash

SENTRY_CONF_FILE=${SENTRY_CONF_FILE:-/etc/sentry.conf.py}
Username=admin
Email=xxx@163.com
Password=admin

# export env var for other scripts to work
export SENTRY_CONF=$SENTRY_CONF_FILE
SCRIPTS_DIR=${SENTRY_SCRIPTS_DIR:-/etc}

/usr/bin/redis-server /etc/redis/redis.conf 

# if starting the web worker then try to initialize DB and superuser
if [ "$1" == "start" ] || [ "$1" == "prepare" ]; then

if [ ! -f /etc/sentry.db ];then
sentry --config=$SENTRY_CONF_FILE upgrade --noinput

/usr/bin/expect << EOF

spawn sentry --config=$SENTRY_CONF_FILE createsuperuser

expect "Username:"
send "$Username\r"
expect "Email address:"
send "$Email\r"
expect "Password: "
send "$Password\r"
expect "Password (again): "
send "$Password\r"
expect "Superuser created successfully."
EOF
fi

fi

if [ "$1" != "prepare" ]; then
    exec sentry --config=$SENTRY_CONF_FILE $@
fi
