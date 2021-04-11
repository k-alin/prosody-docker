#!/bin/bash

echo "Virtual host for: ${host}"

if [ -f /tmp/certs/certs/${host}.crt ]; then
    mv /tmp/certs/certs/${host}.crt /tmp/certs/private/${host}.key /etc/prosody/certs/
fi

sed -e "s/HOST/${host}/ 
        s/XMPP_SERVER_URL/${XMPP_SERVER_URL}/
        s/XMPP_GROUPS_URL/${XMPP_GROUPS_URL}/" \
        /entrypoint/examplevhost.txt \
        >> /etc/prosory/virtual-hosts.cfg.lua
