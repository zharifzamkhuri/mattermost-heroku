#!/bin/bash

[[ ${FILE_SETTINGS__DRIVER_NAME} != "local" ]] || echo "WARNING!!!!! FILES ARE STORED ON DISK AND WILL BE REGULARLY REMOVED, THIS MEANS UPLOADS WILL DISAPEAR!!"

###################################################################################
# Apply some defaults values, and remove quotes that Heroku adds to truthy values #
###################################################################################

####################
# Service Settings #
####################
export ENABLE_OUTGOING_WEBHOOKS=`echo ${ENABLE_OUTGOING_WEBHOOKS:=false} | tr -d \"`
export ENABLE_POST_USERNAME_OVERRIDE=`echo ${ENABLE_POST_USERNAME_OVERRIDE:=false} | tr -d \"`
export ENABLE_POST_ICON_OVERRIDE=`echo ${ENABLE_POST_ICON_OVERRIDE:=false} | tr -d \"`


#################
# Team Settings #
#################
export ENABLE_TEAM_CREATION=`echo ${ENABLE_TEAM_CREATION:=false} | tr -d \"`
export ENABLE_USER_CREATION=`echo ${ENABLE_USER_CREATION:=false} | tr -d \"`
export ENABLE_TEAM_LISTING=`echo ${ENABLE_TEAM_LISTING:=false} | tr -d \"`
export ENABLE_OPEN_SERVER=`echo ${ENABLE_OPEN_SERVER:=false} | tr -d \"`
export RESTRICT_PUBLIC_CHANNEL_MANAGEMENT=${RESTRICT_PUBLIC_CHANNEL_MANAGEMENT:="all"}
export ENABLE_CUSTOM_BRAND=`echo ${ENABLE_CUSTOM_BRAND:=false} | tr -d \"`
export CUSTOM_BRAND_TEXT=${CUSTOM_BRAND_TEXT}
export CUSTOM_DESCRIPTION_TEXT=${CUSTOM_DESCRIPTION_TEXT}


####################
# Support Settings #
####################
export TERMS_OF_SERVICE_LINK=${TERMS_OF_SERVICE_LINK}
export PRIVACY_POLICY_LINK=${PRIVACY_POLICY_LINK}
export ABOUT_LINK=${ABOUT_LINK}
export HELP_LINK=${HELP_LINK}
export REPORT_PROBLEM_LINK=${REPORT_PROBLEM_LINK}
export SUPPORT_EMAIL=${SUPPORT_EMAIL}
export ENABLE_COMMANDS=`echo ${ENABLE_COMMANDS:=false} | tr -d \"`
export ENABLE_2FA=`echo ${ENABLE_2FA:=false} | tr -d \"`


################
# SQL Settings #
################
export SQL_SETTINGS__AT_REST_ENCRYPT_KEY=$(printf "${SQL_SETTINGS__AT_REST_ENCRYPT_KEY}%.0s" {1..32} | cut -c -32)


################
# Log Settings #
################
export LOG_LEVEL=${LOG_LEVEL:="DEBUG"}
export ENABLE_FILE=`echo ${ENABLE_FILE:=false} | tr -d \"`


#################
# File Settings #
#################
export FILE_SETTINGS__PUBLIC_LINK_SALT=$(printf "${FILE_SETTINGS__PUBLIC_LINK_SALT}%.0s" {1..32} | cut -c -32)


##################
# Email Settings #
##################
export ENABLE_SIGNUP_WITH_EMAIL=`echo ${ENABLE_SIGNUP_WITH_EMAIL:=false} | tr -d \"`
export SEND_EMAIL_NOTIFICATIONS=`echo ${SEND_EMAIL_NOTIFICATIONS:=false} | tr -d \"`
export REQUIRE_EMAIL_VERIFICATION=`echo ${REQUIRE_EMAIL_VERIFICATION:=false} | tr -d \"`
export EMAIL_SETTINGS__INVITE_SALT=$(printf "${EMAIL_SETTINGS__INVITE_SALT}%.0s" {1..32} | cut -c -32)
export EMAIL_SETTINGS__PASSWORD_RESET_SALT=$(printf "${EMAIL_SETTINGS__PASSWORD_RESET_SALT}%.0s" {1..32} | cut -c -32)
export PUSH_NOTIFICATION_CONTENTS=${PUSH_NOTIFICATION_CONTENTS:="full"}
export SEND_PUSH_NOTIFICATIONS=`echo ${SEND_PUSH_NOTIFICATIONS:=false} | tr -d \"`


#######################
# Rate Limit Settings #
#######################
export VARY_BY_REMOTE_ADDR=`echo ${VARY_BY_REMOTE_ADDR:=false} | tr -d \"`


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
