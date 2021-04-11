-- Standard host
VirtualHost ("{{XMPP_SERVER_URL}}")
        ssl = {
                certificate = "/etc/prosody/certs/{{XMPP_SERVER_URL}}.crt";
                key = "/etc/prosody/certs/{{XMPP_SERVER_URL}}.key";
        }
        disco_items = {
                { "{{XMPP_GROUPS_URL}}", "A group chat (muc) service" };
        }

-- Virtual hosts (optional)
