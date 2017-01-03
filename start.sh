#!/bin/bash

[[ ${FILE_SETTINGS__DRIVER_NAME} != "local" ]] || echo "WARNING!!!!! FILES ARE STORED ON DISK AND WILL BE REGULARLY REMOVED, THIS MEANS UPLOADS WILL DISAPEAR!!"

###############################################################################################
# Apply some defaults values, and remove quotes that Heroku adds to truthy and numeric values #
###############################################################################################

####################
# Service Settings #
####################
export MAXIMUM_LOGIN_ATTEMPTS=`echo ${MAXIMUM_LOGIN_ATTEMPTS:=10} | tr -d \"`
export ENABLE_OAUTH_SERVICE_PROVIDER=`echo ${ENABLE_OAUTH_SERVICE_PROVIDER:=false} | tr -d \"`
export ENABLE_INCOMING_WEBHOOKS=`echo ${ENABLE_INCOMING_WEBHOOKS:=true} | tr -d \"`
export ENABLE_OUTGOING_WEBHOOKS=`echo ${ENABLE_OUTGOING_WEBHOOKS:=true} | tr -d \"`
export ENABLE_COMMANDS=`echo ${ENABLE_COMMANDS:=true} | tr -d \"`
export ENABLE_ONLY_ADMIN_INTEGRATIONS=`echo ${ENABLE_ONLY_ADMIN_INTEGRATIONS:=true} | tr -d \"`
export ENABLE_POST_USERNAME_OVERRIDE=`echo ${ENABLE_POST_USERNAME_OVERRIDE:=false} | tr -d \"`
export ENABLE_POST_ICON_OVERRIDE=`echo ${ENABLE_POST_ICON_OVERRIDE:=false} | tr -d \"`
export ENABLE_TESTING=`echo ${ENABLE_TESTING:=false} | tr -d \"`
export ENABLE_DEVELOPER=`echo ${ENABLE_DEVELOPER:=false} | tr -d \"`
export ENABLE_SECURITY_FIX_ALERT=`echo ${ENABLE_SECURITY_FIX_ALERT:=true} | tr -d \"`
export ENABLE_INSECURE_OUTGOING_CONNECTIONS=`echo ${ENABLE_INSECURE_OUTGOING_CONNECTIONS:=false} | tr -d \"`
export ENABLE_2FA=`echo ${ENABLE_2FA:=false} | tr -d \"`
export ENABLE_CUSTOM_EMOJI=`echo ${ENABLE_CUSTOM_EMOJI:=false} | tr -d \"`

export SESSION_LENGTH_WEB_IN_DAYS=`echo ${SESSION_LENGTH_WEB_IN_DAYS:=30} | tr -d \"`
export SESSION_LENGTH_MOBILE_IN_DAYS=`echo ${SESSION_LENGTH_MOBILE_IN_DAYS:=30} | tr -d \"`
export SESSION_LENGTH_SSO_IN_DAYS=`echo ${SESSION_LENGTH_SSO_IN_DAYS:=30} | tr -d \"`
export SESSION_CACHE_IN_MINUTES=`echo ${SESSION_CACHE_IN_MINUTES:=10} | tr -d \"`
export WEBSOCKET_SECURE_PORT=`echo ${WEBSOCKET_SECURE_PORT:=443} | tr -d \"`
export WEBSOCKET_PORT=`echo ${WEBSOCKET_PORT:=80} | tr -d \"`

#################
# Team Settings #
#################
export ENABLE_TEAM_CREATION=`echo ${ENABLE_TEAM_CREATION:=false} | tr -d \"`
export ENABLE_USER_CREATION=`echo ${ENABLE_USER_CREATION:=false} | tr -d \"`
export ENABLE_TEAM_LISTING=`echo ${ENABLE_TEAM_LISTING:=false} | tr -d \"`
export ENABLE_OPEN_SERVER=`echo ${ENABLE_OPEN_SERVER:=false} | tr -d \"`
export ENABLE_CUSTOM_BRAND=`echo ${ENABLE_CUSTOM_BRAND:=false} | tr -d \"`
export MAX_USERS_PER_TEAM=`echo ${MAX_USERS_PER_TEAM:=50} | tr -d \"`
export RESTRICT_TEAM_NAMES=`echo ${RESTRICT_TEAM_NAMES:=true} | tr -d \"`
export USER_STATUS_AWAY_TIMEOUT=`echo ${USER_STATUS_AWAY_TIMEOUT:=300} | tr -d \"`
export RESTRICT_DIRECT_MESSAGE=`echo ${RESTRICT_DIRECT_MESSAGE:="any"}`

################
# SQL Settings #
################
export DRIVER_NAME=`echo ${DRIVER_NAME:="postgres"}`
export SQL_SETTINGS__AT_REST_ENCRYPT_KEY=$(printf "${SQL_SETTINGS__AT_REST_ENCRYPT_KEY}%.0s" {1..32} | cut -c -32)
export MAX_IDLE_CONNS=`echo ${MAX_IDLE_CONNS:=10} | tr -d \"`
export MAX_OPEN_CONNS=`echo ${MAX_OPEN_CONNS:=10} | tr -d \"`
export TRACE=`echo ${TRACE:=false} | tr -d \"`

################
# Log Settings #
################
export ENABLE_CONSOLE=`echo ${ENABLE_CONSOLE:=true} | tr -d \"`
export ENABLE_FILE=`echo ${ENABLE_FILE:=false} | tr -d \"`
export ENABLE_WEBHOOK_DEBUGGING=`echo ${ENABLE_WEBHOOK_DEBUGGING:=true} | tr -d \"`
export ENABLE_DIAGNOSTICS=`echo ${ENABLE_DIAGNOSTICS:=true} | tr -d \"`

#################
# File Settings #
#################
export FILE_SETTINGS__PUBLIC_LINK_SALT=$(printf "${FILE_SETTINGS__PUBLIC_LINK_SALT}%.0s" {1..32} | cut -c -32)
export INITIAL_FONT=`echo ${INITIAL_FONT:="luximbi.ttf"}`

export MAX_FILE_SIZE=`echo ${MAX_FILE_SIZE:=52428800} | tr -d \"`
export ENABLE_PUBLIC_LINK=`echo ${ENABLE_PUBLIC_LINK:=false} | tr -d \"`
export THUMBNAIL_WIDTH=`echo ${THUMBNAIL_WIDTH:=120} | tr -d \"`
export THUMBNAIL_HEIGHT=`echo ${THUMBNAIL_HEIGHT:=100} | tr -d \"`
export PREVIEW_WIDTH=`echo ${PREVIEW_WIDTH:=1024} | tr -d \"`
export PREVIEW_HEIGHT=`echo ${PREVIEW_HEIGHT:=0} | tr -d \"`
export PROFILE_WIDTH=`echo ${PROFILE_WIDTH:=128} | tr -d \"`
export PROFILE_HEIGHT=`echo ${PROFILE_HEIGHT:=128} | tr -d \"`
export FILE_SETTINGS__AMAZON_S3_LOCATION_CONSTRAINT=`echo ${FILE_SETTINGS__AMAZON_S3_LOCATION_CONSTRAINT:=false} | tr -d \"`
export FILE_SETTINGS__LOWERCASE_BUCKET=`echo ${FILE_SETTINGS__LOWERCASE_BUCKET:=false} | tr -d \"`

##################
# Email Settings #
##################
export EMAIL_SETTINGS__INVITE_SALT=$(printf "${EMAIL_SETTINGS__INVITE_SALT}%.0s" {1..32} | cut -c -32)
export EMAIL_SETTINGS__PASSWORD_RESET_SALT=$(printf "${EMAIL_SETTINGS__PASSWORD_RESET_SALT}%.0s" {1..32} | cut -c -32)

export ENABLE_SIGNUP_WITH_EMAIL=`echo ${ENABLE_SIGNUP_WITH_EMAIL:=true} | tr -d \"`
export ENABLE_SIGNIN_WITH_EMAIL=`echo ${ENABLE_SIGNIN_WITH_EMAIL:=true} | tr -d \"`
export ENABLE_SIGNIN_WITH_USERNAME=`echo ${ENABLE_SIGNIN_WITH_USERNAME:=true} | tr -d \"`
export SEND_EMAIL_NOTIFICATIONS=`echo ${SEND_EMAIL_NOTIFICATIONS:=false} | tr -d \"`
export REQUIRE_EMAIL_VERIFICATION=`echo ${REQUIRE_EMAIL_VERIFICATION:=false} | tr -d \"`
export SEND_PUSH_NOTIFICATIONS=`echo ${SEND_PUSH_NOTIFICATIONS:=false} | tr -d \"`
export ENABLE_EMAIL_BATCHING=`echo ${ENABLE_EMAIL_BATCHING:=false} | tr -d \"`
export EMAIL_BATCHING_BUFFER_SIZE=`echo ${EMAIL_BATCHING_BUFFER_SIZE:=256} | tr -d \"`
export EMAIL_BATCHING_INTERVAL=`echo ${EMAIL_BATCHING_INTERVAL:=30} | tr -d \"`

#######################
# Rate Limit Settings #
#######################
export VARY_BY_REMOTE_ADDR=`echo ${VARY_BY_REMOTE_ADDR:=false} | tr -d \"`
export ENABLE_RATE_LIMITER=`echo ${ENABLE_RATE_LIMITER:=true} | tr -d \"`
export RATE_PER_SEC=`echo ${RATE_PER_SEC:=10} | tr -d \"`
export RATELIMIT_MEM_STORE_SIZE=`echo ${RATELIMIT_MEM_STORE_SIZE:=10000} | tr -d \"`
export MAX_BURST=`echo ${MAX_BURST:=100} | tr -d \"`

####################
# Privacy Settings #
####################
export SHOW_EMAIL_ADDRESS=`echo ${SHOW_EMAIL_ADDRESS:=true} | tr -d \"`
export SHOW_FULL_NAME=`echo ${SHOW_FULL_NAME:=true} | tr -d \"`

#####################
# Password Settings #
#####################
export PASSWORD_MININMUM_LENGTH=`echo ${PASSWORD_MININMUM_LENGTH:=8} | tr -d \"`
export PASSWORD_LOWERCASE=`echo ${PASSWORD_LOWERCASE:=false} | tr -d \"`
export PASSWORD_NUMBER=`echo ${PASSWORD_NUMBER:=false} | tr -d \"`
export PASSWORD_UPEPRCASE=`echo ${PASSWORD_UPEPRCASE:=false} | tr -d \"`
export PASSWORD_SYMBOL=`echo ${PASSWORD_SYMBOL:=false} | tr -d \"`

##########################
# SSO/LDAP/SAML Settings #
##########################
export ENABLE_GITLAB=`echo ${ENABLE_GITLAB:=false} | tr -d \"`
export ENABLE_GOOGLE=`echo ${ENABLE_GOOGLE:=false} | tr -d \"`
export ENABLE_OFFICE365=`echo ${ENABLE_OFFICE365:=false} | tr -d \"`

export ENABLE_LDAP=`echo ${ENABLE_LDAP:=false} | tr -d \"`
export LDAP_PORT=`echo ${LDAP_PORT:=389} | tr -d \"`
export LDAP_SYNC_INTERVAL=`echo ${LDAP_SYNC_INTERVAL:=60} | tr -d \"`
export LDAP_SKIP_CERT_VERIFICATION=`echo ${LDAP_SKIP_CERT_VERIFICATION:=false} | tr -d \"`
export LDAP_QUERY_TIMEOUT=`echo ${LDAP_QUERY_TIMEOUT:=60} | tr -d \"`
export LDAP_MAX_PAGE_SIZE=`echo ${LDAP_MAX_PAGE_SIZE:=0} | tr -d \"`

export ENABLE_SAML=`echo ${ENABLE_SAML:=false} | tr -d \"`
export ENABLE_SAML_VERIFY=`echo ${ENABLE_SAML_VERIFY:=false} | tr -d \"`
export ENABLE_SAML_ENCRYPT=`echo ${ENABLE_SAML_ENCRYPT:=false} | tr -d \"`

#######################
# Compliance Settings #
#######################
export ENABLE_COMPLIANCE=`echo ${ENABLE_COMPLIANCE:=false} | tr -d \"`
export ENABLE_DAILY_COMPLIANCE=`echo ${ENABLE_DAILY_COMPLIANCE:=false} | tr -d \"`

####################
# Cluster Settings #
####################
export ENABLE_CLUSTER=`echo ${ENABLE_CLUSTER:=false} | tr -d \"`
export CLUSTER_INTER_NODE_URLS=`echo ${CLUSTER_INTER_NODE_URLS:1:${#CLUSTER_INTER_NODE_URLS}-2}`

####################
# Web RTC Settings #
####################
export ENABLE_WEB_RTC=`echo ${ENABLE_WEB_RTC:=false} | tr -d \"`

########################################################################
# Write Config variables in envrionment to the configuration JSON file #
########################################################################
lib/envsubst < config/config-heroku-template.json > config/config-heroku.json


###################################
# Pass SIGTERM to mattermost proc #
###################################
function _term {
  echo "Sending SIGTERM to mattermost"

  kill --TERM "$PID" 2>/dev/null
}

trap _term SIGTERM


####################
# Start Mattermost #
####################
bin/platform -config=/app/config/config-heroku.json &

PID=$!

#####################################################################
# Let the Mattermost proc start up, then touch /tmp/app-initialized #
# to indicate to the nginx process we're ready for traffic          #
#####################################################################
sleep 3
touch /tmp/app-initialized

#####################################
# Wait for this process to complete #
#####################################
wait "$PID"
