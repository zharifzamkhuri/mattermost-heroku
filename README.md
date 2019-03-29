# Deploy Mattermost Team or Enterprise Edition to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This buildpack is an [inline buildpack](https://github.com/kr/heroku-buildpack-inline/) (tldr: this repo deploys to Heroku and uses itself as a buildpack) for deploying [Mattermost](https://mattermost.org) to [Heroku](https://heroku.com).
It must be used in tandem with [This customized Nginx Buildpack](https://github.com/cadecairos/nginx-buildpack) that allow mattermost to communicate with Nginx using a TCP port instead of a socket.


### Known to work with Mattermost 4.5.0 Team and Enterprise editions

## Configuration options

### Buildpack Specific Variables

Set `MATTERMOST_VERSION` to the release version you'd like to install. i.e. '4.5.0'
Set `MATTERMOST_TYPE` to either 'team' or 'enterprise'

### Mattermost Configuration

Mattermost-Heroku supports every configuration option available in Mattermost (although some make no sense to use with Mattermost+Nginx on Heroku, i.e. "Forward80To443"). To set an environment variable, prefix it with "MM_" followed by the setting type, and then the setting key, in all upper case. [You can read up about how this works in the Mattermost configuration documentation](https://docs.mattermost.com/administration/config-settings.html#configuration-settings)

## Rebuilding

If you maintain a fork of this repo, you can link the Heroku app to your fork, which will enable you to build from the Heroku dashboard's deploy page.

An alternative to this would be to use the [Heroku Build API to create a new build](https://devcenter.heroku.com/articles/build-and-release-using-the-api#creating-builds)

For example, a curl request like this would do the trick (substitute the right variables):

```bash
curl -n -X POST https://api.heroku.com/apps/$YOUR_APP/builds \
-d '{"source_blob": {"url":"https://github.com/mozilla/mattermost-heroku/archive/{$LATEST_BUILDPACK_VERSION}.tar.gz", "version": "${COMMIT_HASH}"}}' \
-H 'Accept: application/vnd.heroku+json; version=3' \
-H "Content-Type: application/json"
```

The "version" parameter is optional in the example above.

This curl request can be made manually from a developer's machine, or it can be set up as a job in something like [Jenkins]()https://jenkins.io/. Keep in mind that Authorization headers will need to be included in the request.

Also, the example above assumes that the machine it's being run on has heroku.com credentials saved in your `~/.netrc` file.

## Warnings

1. Don't make configuration changes in the Mattermost admin console.
   Any configuration changes in the Mattermost admin console will be lost on dyno restart (which may be every 24 hours) and will not be distributed across multiple dynos.
2. Not using s3 means any uploads will be lost on dyno restart or application reconfiguration or redeploy and won't be consistent across multiple dynos.
   Without s3 backing this is not anything more than a one time demo.

## Enterprise Edition
Activate it as instructed in the docs https://docs.mattermost.com/install/ee-install.html



## Environment Variable

|gitlab.rb key|Environment variable|
|---|---|
|service_site_url | MM_SERVICESETTINGS_SITEURL|
|service_maximum_login_attempts | MM_SERVICESETTINGS_MAXIMUMLOGINATTEMPTS|
|service_google_developer_key | MM_SERVICESETTINGS_GOOGLEDEVELOPERKEY|
|service_enable_incoming_webhooks | MM_SERVICESETTINGS_ENABLEINCOMINGWEBHOOKS|
|service_enable_post_username_override | MM_SERVICESETTINGS_ENABLEPOSTUSERNAMEOVERRIDE|
|service_enable_post_icon_override | MM_SERVICESETTINGS_ENABLEPOSTICONOVERRIDE|
|service_enable_testing | MM_SERVICESETTINGS_ENABLETESTING|
|service_enable_security_fix_alert | MM_SERVICESETTINGS_ENABLESECURITYFIXALERT|
|service_enable_insecure_outgoing_connections | MM_SERVICESETTINGS_ENABLEINSECUREOUTGOINGCONNECTIONS|
|service_allowed_untrusted_internal_connections | MM_SERVICESETTINGS_ALLOWEDUNTRUSTEDINTERNALCONNECTIONS|
|service_allow_cors_from | MM_SERVICESETTINGS_ALLOWCORSFROM|
|service_enable_outgoing_webhooks | MM_SERVICESETTINGS_ENABLEOUTGOINGWEBHOOKS|
|service_enable_commands | MM_SERVICESETTINGS_ENABLECOMMANDS|
|service_enable_custom_emoji | MM_SERVICESETTINGS_ENABLECUSTOMEMOJI|
|service_enable_only_admin_integrations | MM_SERVICESETTINGS_ENABLEONLYADMININTEGRATIONS|
|service_enable_oauth_service_provider | MM_SERVICESETTINGS_ENABLEOAUTHSERVICEPROVIDER|
|service_enable_developer | MM_SERVICESETTINGS_ENABLEDEVELOPER|
|service_session_length_web_in_days | MM_SERVICESETTINGS_SESSIONLENGTHWEBINDAYS|
|service_session_length_mobile_in_days | MM_SERVICESETTINGS_SESSIONLENGTHMOBILEINDAYS|
|service_session_length_sso_in_days | MM_SERVICESETTINGS_SESSIONLENGTHSSOINDAYS|
|service_session_cache_in_minutes | MM_SERVICESETTINGS_SESSIONCACHEINMINUTES|
|service_connection_security | MM_SERVICESETTINGS_CONNECTIONSECURITY|
|service_tls_cert_file | MM_SERVICESETTINGS_TLSCERTFILE|
|service_tls_key_file | MM_SERVICESETTINGS_TLSKEYFILE|
|service_use_lets_encrypt | MM_SERVICESETTINGS_USELETSENCRYPT|
|service_lets_encrypt_cert_cache_file | MM_SERVICESETTINGS_LETSENCRYPTCERTIFICATECACHEFILE|
|service_forward_80_to_443 | MM_SERVICESETTINGS_FORWARD80TO443|
|service_read_timeout | MM_SERVICESETTINGS_READTIMEOUT|
|service_write_timeout | MM_SERVICESETTINGS_WRITETIMEOUT|
|service_time_between_user_typing_updates_milliseconds | MM_SERVICESETTINGS_TIMEBETWEENUSERTYPINGUPDATESMILLISECONDS|
|service_enable_link_previews | MM_SERVICESETTINGS_ENABLELINKPREVIEWS|
|service_enable_user_typing_messages | MM_SERVICESETTINGS_ENABLEUSERTYPINGMESSAGES|
|service_enable_post_search | MM_SERVICESETTINGS_ENABLEPOSTSEARCH|
|service_enable_user_statuses | MM_SERVICESETTINGS_ENABLEUSERSTATUSES|
|service_enable_emoji_picker | MM_SERVICESETTINGS_ENABLEEMOJIPICKER|
|service_enable_channel_viewed_messages | MM_SERVICESETTINGS_ENABLECHANNELVIEWEDMESSAGES|
|service_enable_apiv3 | MM_SERVICESETTINGS_ENABLEAPIV3|
|service_goroutine_health_threshold | MM_SERVICESETTINGS_GOROUTINEHEALTHTHRESHOLD|
|service_user_access_tokens | MM_SERVICESETTINGS_USERACCESSTOKENS|
|team_site_name | MM_TEAMSETTINGS_SITENAME|
|team_max_users_per_team | MM_TEAMSETTINGS_MAXUSERSPERTEAM|
|team_enable_team_creation | MM_TEAMSETTINGS_ENABLETEAMCREATION|
|team_enable_user_creation | MM_TEAMSETTINGS_ENABLEUSERCREATION|
|team_enable_open_server | MM_TEAMSETTINGS_ENABLEOPENSERVER|
|team_allow_public_link | MM_TEAMSETTINGS_ALLOWPUBLICLINK|
|team_allow_valet_default | MM_TEAMSETTINGS_ALLOWVALETDEFAULT|
|team_restrict_creation_to_domains | MM_TEAMSETTINGS_RESTRICTCREATIONTODOMAINS|
|team_restrict_team_names | MM_TEAMSETTINGS_RESTRICTTEAMNAMES|
|team_restrict_direct_message | MM_TEAMSETTINGS_RESTRICTDIRECTMESSAGE|
|team_max_channels_per_team | MM_TEAMSETTINGS_MAXCHANNELSPERTEAM|
|team_enable_x_to_leave_channels_from_lhs | MM_TEAMSETTINGS_ENABLEXTOLEAVECHANNELSFROMLHS|
|team_user_status_away_timeout | MM_TEAMSETTINGS_USERSTATUSAWAYTIMEOUT|
|team_teammate_name_display | MM_TEAMSETTINGS_TEAMMATENAMEDISPLAY|
|sql_driver_name | MM_SQLSETTINGS_DRIVERNAME|
|sql_data_source | MM_SQLSETTINGS_DATASOURCE|
|sql_data_source_replicas | MM_SQLSETTINGS_DATASOURCEREPLICAS|
|sql_max_idle_conns | MM_SQLSETTINGS_MAXIDLECONNS|
|sql_max_open_conns | MM_SQLSETTINGS_MAXOPENCONNS|
|sql_trace | MM_SQLSETTINGS_TRACE|
|sql_data_source_search_replicas | MM_SQLSETTINGS_DATASOURCESEARCHREPLICAS|
|sql_query_timeout | MM_SQLSETTINGS_QUERYTIMEOUT|
|log_file_directory | MM_LOGSETTINGS_FILEDIRECTORY|
|log_console_enable | MM_LOGSETTINGS_ENABLECONSOLE|
|log_console_level | MM_LOGSETTINGS_CONSOLELEVEL|
|log_enable_file | MM_LOGSETTINGS_ENABLEFILE|
|log_file_level | MM_LOGSETTINGS_FILELEVEL|
|log_file_format | MM_LOGSETTINGS_FILEFORMAT|
|log_enable_diagnostics | MM_LOGSETTINGS_ENABLEDIAGNOSTICS|
|gitlab_enable | MM_GITLABSETTINGS_ENABLE|
|gitlab_id | MM_GITLABSETTINGS_ID|
|gitlab_secret | MM_GITLABSETTINGS_SECRET|
|gitlab_scope | MM_GITLABSETTINGS_SCOPE|
|gitlab_auth_endpoint | MM_GITLABSETTINGS_AUTHENDPOINT|
|gitlab_token_endpoint | MM_GITLABSETTINGS_TOKENENDPOINT|
|gitlab_user_api_endpoint | MM_GITLABSETTINGS_USERAPIENDPOINT|
|email_enable_sign_up_with_email | MM_EMAILSETTINGS_ENABLESIGNUPWITHEMAIL|
|email_enable_sign_in_with_email | MM_EMAILSETTINGS_ENABLESIGNINWITHEMAIL|
|email_enable_sign_in_with_username | MM_EMAILSETTINGS_ENABLESIGNINWITHUSERNAME|
|email_send_email_notifications | MM_EMAILSETTINGS_SENDEMAILNOTIFICATIONS|
|email_require_email_verification | MM_EMAILSETTINGS_REQUIREEMAILVERIFICATION|
|email_smtp_username | MM_EMAILSETTINGS_SMTPUSERNAME|
|email_smtp_password | MM_EMAILSETTINGS_SMTPPASSWORD|
|email_smtp_server | MM_EMAILSETTINGS_SMTPSERVER|
|email_smtp_port | MM_EMAILSETTINGS_SMTPPORT|
|email_connection_security | MM_EMAILSETTINGS_CONNECTIONSECURITY|
|email_feedback_name | MM_EMAILSETTINGS_FEEDBACKNAME|
|email_feedback_email | MM_EMAILSETTINGS_FEEDBACKEMAIL|
|email_feedback_organization | MM_EMAILSETTINGS_FEEDBACKORGANIZATION|
|email_send_push_notifications | MM_EMAILSETTINGS_SENDPUSHNOTIFICATIONS|
|email_push_notification_server | MM_EMAILSETTINGS_PUSHNOTIFICATIONSERVER|
|email_push_notification_contents | MM_EMAILSETTINGS_PUSHNOTIFICATIONCONTENTS|
|email_enable_batching | MM_EMAILSETTINGS_ENABLEEMAILBATCHING|
|email_batching_buffer_size | MM_EMAILSETTINGS_BATCHINGBUFFERSIZE|
|email_batching_interval | MM_EMAILSETTINGS_BATCHINGINTERVAL|
|email_skip_server_certificate_verification | MM_EMAILSETTINGS_SKIPSERVERCERTIFICATEVERIFICATION|
|email_smtp_auth | MM_EMAILSETTINGS_SMTPAUTH|
|email_notification_content_type | MM_EMAILSETTINGS_NOTIFICATIONCONTENTTYPE|
|file_max_file_size | MM_FILESETTINGS_MAXFILESIZE|
|file_driver_name | MM_FILESETTINGS_DRIVERNAME|
|file_directory | MM_FILESETTINGS_DIRECTORY|
|file_enable_public_link | MM_FILESETTINGS_ENABLEPUBLICLINK|
|file_initial_font | MM_FILESETTINGS_INITIALFONT|
|file_amazon_s3_access_key_id | MM_FILESETTINGS_AMAZONS3ACCESSKEYID|
|file_amazon_s3_bucket | MM_FILESETTINGS_AMAZONS3BUCKET|
|file_amazon_s3_secret_access_key | MM_FILESETTINGS_AMAZONS3SECRETACCESSKEY|
|file_amazon_s3_region | MM_FILESETTINGS_AMAZONS3REGION|
|file_amazon_s3_endpoint | MM_FILESETTINGS_AMAZONS3ENDPOINT|
|file_amazon_s3_bucket_endpoint | MM_FILESETTINGS_AMAZONS3BUCKETENDPOINT|
|file_amazon_s3_location_constraint | MM_FILESETTINGS_AMAZONS3LOCATIONCONSTRAINT|
|file_amazon_s3_lowercase_bucket | MM_FILESETTINGS_AMAZONS3LOWERCASEBUCKET|
|file_amazon_s3_ssl | MM_FILESETTINGS_AMAZONS3SSL|
|file_amazon_s3_sign_v2 | MM_FILESETTINGS_AMAZONS3SIGNV2|
|file_enable_file_attachments | MM_FILESETTINGS_ENABLEFILEATTACHMENTS|
|file_amazon_s3_trace | MM_FILESETTINGS_AMAZONS3TRACE|
|ratelimit_enable_rate_limiter | MM_RATELIMITSETTINGS_ENABLE|
|ratelimit_per_sec | MM_RATELIMITSETTINGS_PERSEC|
|ratelimit_memory_store_size | MM_RATELIMITSETTINGS_MEMORYSTORESIZE|
|ratelimit_vary_by_remote_addr | MM_RATELIMITSETTINGS_VARYBYREMOTEADDR|
|ratelimit_vary_by_header | MM_RATELIMITSETTINGS_VARYBYHEADER|
|ratelimit_max_burst | MM_RATELIMITSETTINGS_MAXBURST|
|support_terms_of_service_link | MM_SUPPORTSETTINGS_TERMSOFSERVICELINK|
|support_privacy_policy_link | MM_SUPPORTSETTINGS_PRIVACYPOLICYLINK|
|support_about_link | MM_SUPPORTSETTINGS_ABOUTLINK|
|support_report_a_problem_link | MM_SUPPORTSETTINGS_REPORTAPROBLEMLINK|
|support_email | MM_SUPPORTSETTINGS_EMAIL|
|privacy_show_email_address | MM_PRIVACYSETTINGS_SHOWEMAILADDRESS|
|privacy_show_full_name | MM_PRIVACYSETTINGS_SHOWFULLNAME|
|localization_server_locale | MM_LOCALIZATIONSETTINGS_SERVERLOCALE|
|localization_client_locale | MM_LOCALIZATIONSETTINGS_CLIENTLOCALE|
|localization_available_locales | MM_LOCALIZATIONSETTINGS_AVAILABLELOCALES|
|webrtc_enable | MM_WEBRTCSETTINGS_ENABLE|
|webrtc_gateway_websocket_url | MM_WEBRTCSETTINGS_GATEWAYWEBSOCKETURL|
|webrtc_gateway_admin_url | MM_WEBRTCSETTINGS_GATEWAYADMINURL|
|webrtc_gateway_admin_secret | MM_WEBRTCSETTINGS_GATEWAYADMINSECRET|
|webrtc_gateway_stun_uri | MM_WEBRTCSETTINGS_STUNURI|
|webrtc_gateway_turn_uri | MM_WEBRTCSETTINGS_TURNURI|
|webrtc_gateway_turn_username | MM_WEBRTCSETTINGS_TURNUSERNAME|
|webrtc_gateway_turn_shared_key | MM_WEBRTCSETTINGS_TURNSHAREDKEY|
