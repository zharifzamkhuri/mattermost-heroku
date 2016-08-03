# Deploy Mattermost Team or Enterprise Edition to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This buildpack is an [inline buildpack](https://github.com/kr/heroku-buildpack-inline/) (tldr: this repo deploys to Heroku and uses itself as a buildpack) for deploying [Mattermost](https://mattermost.org) to [Heroku](https://heroku.com).
It must used in tandem with [This Nginx Buildpack I customized](https://github.com/cadecairos/nginx-buildback). Since Mattermost is not a [12 factor app](http://12factor.net/config), the startup script writes your Heroku environment variables to a config file when the dyno starts up.

### Known to work with Mattermost 3.2.0 Team and Enterprise editions

## Configuration options

### Building

Set `MATTERMOST_VERSION` to the release version you'd like to install.
Set `MATTERMOST_TYPE` to either 'team' or 'enterprise'

### Mattermost

[Check out the configuration docs for more info](https://docs.mattermost.com/administration/config-settings.html)

|Variable|Purpose|type|default|
|--------|-------|----|-------|
|MATTERMOST_PORT|The port you want Nginx and Mattermost to talk to each other on|int|8080|
|ENABLE_OUTGOING_WEBHOOKS|Enable the creation of outgoing webhooks|bool|false|
|ENABLE_POST_USERNAME_OVERRIDE|Allow posts to override the username field, useful for webhook integrations|bool|false|
|ENABLE_POST_ICON_OVERRIDE|Allow posts to override the icon field, useful for webhook integrations|bool|false|
|ENABLE_COMMANDS|Enable custom slash commands|bool|false|
|ENABLE_2FA|Enable Two Factor Authentication (Enterprise only)|bool|false|
|TEAM_SETTINGS__SITE_NAME|The name of your Mattermost site|string|?|
|MAX_USERS_PER_TEAM|Maximum users per team|int|50|
|ENABLE_TEAM_CREATION|Allow new teams to be created|bool|false|
|RESTRICT_CREATION_TO_DOMAINS|Teams and user accounts can only be created by a verified email from this list of comma-separated domains|string|undefined|
|ENABLE_TEAM_LISTING|Teams that are configured to appear in the team directory will appear on the system main page|bool|false|
|ENABLE_OPEN_SERVER|Users can sign up to the server from the root page without an invite|bool|false|
|RESTRICT_PUBLIC_CHANNEL_MANAGEMENT|Restrict the permission levels required to create, delete, rename, and set the header or purpose for public channels (Enterprise only)|bool|false|
|DATABASE_URL|Database connection string|string||
|MAX_IDLE_CONNS|Maximum number of idle connections held open to the database|int|10|
|MAX_OPEN_CONNS|Maximum number of open connections held open to the database|int|10|
|SQL_SETTINGS__AT_REST_ENCRYPT_KEY|32-character salt available to encrypt and decrypt sensitive fields in database|string||
|LOG_LEVEL|Level of detail at which log events are written to the console. DEBUG, ERROR, INFO|string|INFO|
|ENABLE_FILE|Enable or disable logging to file|bool|false|
|FILE_SETTINGS__DRIVER_NAME|set the database driver(mysql or postgres)|string||
|FILE_SETTINGS__PUBLIC_LINK_SALT|32-character salt added to signing of public image links|string||
|FILE_SETTINGS__AMAZON_S3_ACCESS_KEY_ID|key for writing to S3|string||
|FILE_SETTINGS__AMAZON_S3_SECRET_ACCESS_KEY|secret key for writing to S3|string||
|FILE_SETTINGS__AMAZON_S3_BUCKET|S3 bucket to store uploaded content|string||
|FILE_SETTINGS__AMAZON_S3_REGION|S3 region the bucket is located in|string||
|ENABLE_SIGNUP_WITH_EMAIL|Allow team creation and account signup using email and password(set false for LDAP/OAuth signups only)|bool|false|
|SEND_EMAIL_NOTIFICATIONS|Enables sending of email notifications|bool|false|
|REQUIRE_EMAIL_VERIFICATION|Require email verification after account creation prior to allowing login|bool|false|
|FEEDBACK_NAME|Name displayed on email account used when sending notification emails from Mattermost system|string||
|FEEDBACK_EMAIL|Address displayed on email account used when sending notification emails from Mattermost system|string||
|SMTP_USERNAME|username for the SMTP server sending notification emails|string||
|SMTP_PASSWORD|password for the SMTP server sending notification emails|string||
|SMTP_SERVER|hostname for the SMTP server sending notification emails|string||
|SMTP_PORT|port number for the SMTP server sending notification emails|string||
|CONNECTION_SECURITY|Set to TLS to send email over a secure connection|string||
|EMAIL_SETTINGS__INVITE_SALT|32-character salt added to signing of email invites|string||
|EMAIL_SETTINGS__PASSWORD_RESET_SALT|32-character salt added to signing of password reset emails|string||
|SEND_PUSH_NOTIFICATIONS|Send push notifications using the configured push notification server|bool|false|
|PUSH_NOTIFICATION_SERVER|The push notification server to use|string||
|PUSH_NOTIFICATION_CONTENTS|The contents push notifications should have (full, generic)|string|full|
|VARY_BY_REMOTE_ADDR|Rate limit API access by IP address|bool|false|
|VARY_BY_HEADER|Vary rate limiting by HTTP header field specified|string||
|TERMS_OF_SERVICE_LINK|Link to site's TOS|string||
|PRIVACY_POLICY_LINK|Link to site's privacy policy|string||
|ABOUT_LINK|Link to site's about page|string||
|HELP_LINK|Link to help content|string||
|REPORT_PROBLEM_LINK|link to report issues|string||
|SUPPORT_EMAIL|email to send support requests to|string|


## Rebuilding

Use the deploy menu on the Heroku dashboard to trigger manual deploys.

## Warnings

1. Don't make configuration changes in the Mattermost admin console.
   Any configuration changes in the Mattermost admin console will likely be lost on dyno restart (which may be every 24 hours) and will likely not be distributed across multiple dynos.
2. Not using s3 means any uploads will be lost on dyno restart or application reconfiguration or redeploy and won't be consistent across multiple dynos.
   Without s3 backing this is not anything more than a one time demo.

## Enterprise Edition
Activate it as instructed in the docs https://docs.mattermost.com/install/ee-install.html


## To Do

* Add more config options
* Cache Node tarball
