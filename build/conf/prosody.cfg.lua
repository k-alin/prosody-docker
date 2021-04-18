-- Prosody XMPP Server Configuration
--
---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default settings
-- for any virtual hosts

admins = { "{{XMPP_ADMIN}}" }

-- Paths for data and modules
data_path = "/var/lib/prosody/data"

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
use_libevent = true

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = false

-- Force clients to use encrypted connections? This option will
-- prevent clients from authenticating unless they are using encryption.
c2s_require_encryption = true

-- Force certificate authentication for server-to-server connections?
s2s_secure_auth = true
s2s_insecure_domains = {}

legacy_ssl_ports = { 5223 }

-- Main encrytion keys for this instance
ssl = {
    key = "/etc/prosody/certs/{{XMPP_SERVER_URL}}.key";
    certificate = "/etc/prosody/certs/{{XMPP_SERVER_URL}}.crt";
}

-- Required for init scripts posix and prosodyctl
pidfile = "/var/run/prosody/prosody.pid"

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
log = {
    {levels = {min = "info"}, to = "console"};
};

-- HTTP Settings
-- bind to traditional BOSH port on localhost only, don't use HTTPS
-- as this sits behind a reverse proxy that handles HTTPS.
http_host = "{{XMPP_SERVER_URL}}"
http_external_url = "https://{{XMPP_SERVER_URL}}/"
http_paths = {
    bosh = "/_xmpp/http-bind"; 
    register_web = "/_xmpp/register";
    websocket = "/_xmpp/websocket"
}

-- Registration settings
-- Allow only one registration every 5 minutes
-- registration_throttle_max = 1
-- registration_throttle_period = 300
-- register_web_template = "/usr/lib/prosody-register-web-template"

-- BOSH and websocket settings
-- cross_domain_bosh = "*";
cross_domain_websocket = true;
consider_websocket_secure = true;
consider_bosh_secure = true

-- MAM
archive_expires_after = "{{ARCHIVE_EXPIRY}}"

-- HTTP upload settings
http_upload_external_base_url = "https://{{XMPP_SERVER_URL}}/_xmpp/upload/"
http_upload_external_secret = "{{SECRET}}"
http_upload_external_file_size_limit = 50000000 -- 50 MB


-- Select the authentication backend to use. The 'internal' providers
-- use Prosody's configured data storage to store the authentication data.
-- To allow Prosody to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please see http://prosody.im/doc/modules/mod_auth_internal_hashed
-- for information about using the hashed backend.
authentication = "internal_plain"


-- Provide information where to contact the administrator
contact_info = {
    abuse = { "mailto:{{ADMIN_EMAIL}}", "xmpp:{{XMPP_ADMIN}}" };
    admin = { "mailto:{{ADMIN_EMAIL}}", "xmpp:{{XMPP_ADMIN}}" };
  };

-- SMACK settings 
smacks_enabled_s2s = true
smacks_hibernation_time = 3600 
smacks_max_unacked_stanzas = 10
smacks_max_ack_delay = 60
smacks_max_hibernated_sessions = 10
smacks_max_old_sessions = 10

-- Push fix for ChatSecure
push_notification_important_body = "New Message"

-- Most of configuration is split up in separate files
include "sql.cfg.lua";
Include "modules.cfg.lua";
Include "components.cfg.lua";
Include "virtual-hosts.cfg.lua";

-- Service Discovery
disco_items = {
  { "{{XMPP_GROUPS_URL}}", "The multi user chat groups" };
}

-- Include configuration to be added if needed (for example for more hosts)
Include "conf.d/*.cfg.lua";
