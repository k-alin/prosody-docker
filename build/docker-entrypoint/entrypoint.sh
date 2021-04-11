#!/bin/sh

# Function to generate a random salt
generate_salt() {
  tr -dc 'a-zA-Z0-9' </dev/urandom | fold -w 48 | head -n 1
}

# Check if required variables are available
if [ -z "${XMPP_SERVER_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_SERVER_URL must be set."
elif [ -z "${XMPP_GROUPS_URL}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_GROUPS_URL must be set."
elif [ -z "${XMPP_EMAIL}" ]; then
    echo "Failure starting xmpp server: The environment variable ADMIN_EMAIL must be set."
elif [ -z "${XMPP_ADMIN}" ]; then
    echo "Failure starting xmpp server: The environment variable XMPP_ADMIN must be set."
elif [ -z "${SECRET}" ]; then
    echo "Failure starting xmpp server: The environment variable SECRET must be set."

else
    
    echo "Configuring Prosody..."
    echo "Main server url: ${XMPP_SERVER_URL}"
#    echo "HTTP upload endpoint url: ${XMPP_SERVER_URL}/_xmpp/upload"
    echo "Multi user chat (MUC) url: ${XMPP_GROUPS_URL}"
    
    # Replace required variables

    sed -i -e "s/{{ADMIN_EMAIL}}/${XMPP_ADMIN_EMAIL}/
               s/{{XMPP_ADMIN}}/${XMPP_ADMIN}/
	       s/{{DB_HOST}}/${XMPP_DB_HOST}/
	       s/{{DB_PORT}}/${XMPP_DB_PORT}/
	       s/{{DB_NAME}}/${POSTGRESQL_DATABASE}/
	       s/{{DB_USER}}/${POSTGRESQL_USERNAME}/
	       s/{{DB_PASS}}/${POSTGRESQL_PASSWORD}/
               s/{{XMPP_SERVER_URL}}/${XMPP_SERVER_URL}/
               s/{{XMPP_GROUPS_URL}}/${XMPP_GROUPS_URL}/
	       s/{{XMPP_SECRET}}/${SECRET}/" \
               /etc/prosody/prosody.cfg.lua

    sed -i -e "s/{{XMPP_SERVER_URL}}/${XMPP_SERVER_URL}/
               s/{{XMPP_GROUPS_URL}}/${XMPP_GROUPS_URL}/" \ 
               /etc/prosody/components.cfg.lua
    
    sed -i -e "s/{{XMPP_SERVER_URL}}/${XMPP_SERVER_URL}/ 
               s/{{XMPP_GROUPS_URL}}/${XMPP_GROUPS_URL}/" \
               /etc/prosody/virtual-hosts.cfg.lua

    mkdir -p /tmp/certs && mkdir -p /etc/prosody/certs
    
    CERT_PATH=$(find / -name acme.json | grep merged)

    # Prepare certificates to be in the default location where prosody expects them
    if [ -f $CERT_PATH ]; then
        traefik-certs-dumper file --source /cert/acme.json --dest /tmp/certs --version v2
        mv /tmp/certs/certs/${XMPP_SERVER_URL}.crt /tmp/certs/private/${XMPP_SERVER_URL}.key /etc/prosody/certs/
        mv /tmp/certs/certs/${XMPP_GROUPS_URL}.crt /tmp/certs/private/${XMPP_GROUPS_URL}.key /etc/prosody/certs/
    fi

    # Eventually add virtual hosts
    hosts="${XMPP_HOST_URL_1} ${XMPP_HOST_URL_2} ${XMPP_HOST_URL_3}"
    
    for host in ${hosts}; do
        ./vhosts.sh    

    done

    # Make sure everything has the right owner
    chown -R prosody:prosody /etc/prosody/certs
    chown -R prosody:prosody /var/lib/prosody/data

    # Go jabber go
    sudo -u prosody prosody -F
fi
