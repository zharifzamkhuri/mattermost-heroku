#!/bin/bash

[[ ${FILE_SETTINGS__DRIVER_NAME} != "local" ]] || echo "WARNING!!!!! FILES ARE STORED ON DISK AND WILL BE REGULARLY REMOVED, THIS MEANS UPLOADS WILL DISAPEAR!!"

# Encryption keys and salts seem to have a requirement of 32 characters but Heroku doesn't
#   define how many characters a secret type generates. This normalises to 32 characters.
SQL_SETTINGS__AT_REST_ENCRYPT_KEY=$(printf "${SQL_SETTINGS__AT_REST_ENCRYPT_KEY}%.0s" {1..32} | cut -c -32)
FILE_SETTINGS__PUBLIC_LINK_SALT=$(printf "${FILE_SETTINGS__PUBLIC_LINK_SALT}%.0s" {1..32} | cut -c -32)
EMAIL_SETTINGS__INVITE_SALT=$(printf "${EMAIL_SETTINGS__INVITE_SALT}%.0s" {1..32} | cut -c -32)
EMAIL_SETTINGS__PASSWORD_RESET_SALT=$(printf "${EMAIL_SETTINGS__PASSWORD_RESET_SALT}%.0s" {1..32} | cut -c -32)

# default s3 stuff to empty if it's not configured
export FILE_SETTINGS__AMAZON_S3_ACCESS_KEY_ID=${FILE_SETTINGS__AMAZON_S3_ACCESS_KEY_ID:=""}
export FILE_SETTINGS__AMAZON_S3_SECRET_ACCESS_KEY=${FILE_SETTINGS__AMAZON_S3_SECRET_ACCESS_KEY:=""}
export FILE_SETTINGS__AMAZON_S3_BUCKET=${FILE_SETTINGS__AMAZON_S3_BUCKET:=""}

# The following values need to be boolean, but heroku only support string values, so we're going to strip out the quotation marks
export ENABLE_SIGNUP_WITH_EMAIL=${ENABLE_SIGNUP_WITH_EMAIL:=false}
export ENABLE_SIGNUP_WITH_EMAIL=`echo ${ENABLE_SIGNUP_WITH_EMAIL} | tr -d \"`

export SEND_EMAIL_NOTIFICATIONS=${SEND_EMAIL_NOTIFICATIONS:=false}
export SEND_EMAIL_NOTIFICATIONS=`echo ${SEND_EMAIL_NOTIFICATIONS} | tr -d \"`

export REQUIRE_EMAIL_VERIFICATION=${REQUIRE_EMAIL_VERIFICATION:=false}
export REQUIRE_EMAIL_VERIFICATION=`echo ${REQUIRE_EMAIL_VERIFICATION} | tr -d \"`

export ENABLE_TEAM_CREATION=${ENABLE_TEAM_CREATION:=false}
export ENABLE_TEAM_CREATION=`echo ${ENABLE_TEAM_CREATION} | tr -d \"`

export ENABLE_USER_CREATION=${ENABLE_USER_CREATION:=false}
export ENABLE_USER_CREATION=`echo ${ENABLE_USER_CREATION} | tr -d \"`

export ENABLE_OUTGOING_WEBHOOKS=${ENABLE_OUTGOING_WEBHOOKS:=false}
export ENABLE_OUTGOING_WEBHOOKS=`echo ${ENABLE_OUTGOING_WEBHOOKS} | tr -d \"`

export ENABLE_POST_USERNAME_OVERRIDE=${ENABLE_POST_USERNAME_OVERRIDE:=false}
export ENABLE_POST_USERNAME_OVERRIDE=`echo ${ENABLE_POST_USERNAME_OVERRIDE} | tr -d \"`

export ENABLE_POST_ICON_OVERRIDE=${ENABLE_POST_ICON_OVERRIDE:=false}
export ENABLE_POST_ICON_OVERRIDE=`echo ${ENABLE_POST_ICON_OVERRIDE} | tr -d \"`

export ENABLE_TEAM_LISTING=${ENABLE_TEAM_LISTING:=false}
export ENABLE_TEAM_LISTING=`echo ${ENABLE_TEAM_LISTING} | tr -d \"`

export SEND_PUSH_NOTIFICATIONS=${SEND_PUSH_NOTIFICATIONS:=false}
export SEND_PUSH_NOTIFICATIONS=`echo ${SEND_PUSH_NOTIFICATIONS} | tr -d \"`

export ENABLE_HSTS=${ENABLE_HSTS:=false}
export ENABLE_HSTS=`echo ${ENABLE_HSTS} | tr -d \"`

export UPGRADE_HTTP=${UPGRADE_HTTP:=false}
export UPGRADE_HTTP=`echo ${UPGRADE_HTTP} | tr -d \"`

export VARY_BY_REMOTE_ADDR=${VARY_BY_REMOTE_ADDR:=false}
export VARY_BY_REMOTE_ADDR=`echo ${VARY_BY_REMOTE_ADDR} | tr -d \"`

export ENABLE_COMMANDS=${ENABLE_COMMANDS:=false}
export ENABLE_COMMANDS=`echo ${ENABLE_COMMANDS} | tr -d \"`

export ENABLE_OPEN_SERVER=${ENABLE_OPEN_SERVER:=false}
export ENABLE_OPEN_SERVER=`echo ${ENABLE_OPEN_SERVER} | tr -d \"`

lib/envsubst < config/config-heroku-template.json > config/config-heroku.json

function _term {
  echo "Sending SIGTERM to mattermost"

  kill --TERM "$PID" 2>/dev/null
}

trap _term SIGTERM

cd /app/platform -config=/app/config/config-heroku.json &

PID=$!

wait "$PID"
