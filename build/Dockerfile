FROM debian:buster-slim

VOLUME ["/etc/prosody"]
VOLUME ["/var/lib/prosody"]

# 5000/tcp: mod_proxy65
# 5222/tcp: client to server
# 5223/tcp: deprecated, SSL client to server
# 5269/tcp: server to server
# 5280/tcp: http server (bosh, http_upload, etc.)
# 5347/tcp: XMPP component
EXPOSE 5222 5223 5269 5280

ENV DEBIAN_FRONTEND noninteractive

# Add backports repository
RUN printf "deb http://deb.debian.org/debian buster-backports main main non-free" > /etc/apt/sources.list.d/backports.list

# Install software
RUN apt-get update --yes && apt-get install -y --no-install-recommends \
        bash \
        lsb-base \
        procps \
        adduser \
        curl \
        jq \
        libidn11 \
        libicu63 \
        libssl1.1 \
        lua-bitop \
        lua-dbi-postgresql \
        lua-event \
        lua-expat \
        lua-filesystem \
        lua-sec \
        lua-socket \
        lua-zlib \
        lua5.1 \
        lua5.2 \
        openssl \
        ca-certificates \
        ssl-cert \
        mercurial \
        git \
        sudo \
    && apt-get -t buster-backports install -y \
        prosody \
        prosody-modules \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Adding additional prosody modules
RUN service prosody stop
WORKDIR /usr/lib/

RUN mkdir -p /var/run/prosody && chown prosody:prosody /var/run/prosody

# Pull traefik-certs-dumper to convert acme.json into crt and key files
RUN curl -ssL https://github.com/ldez/traefik-certs-dumper/releases/download/v2.7.0/traefik-certs-dumper_v2.7.0_linux_amd64.tar.gz | tar xvfz - -C /usr/local/bin traefik-certs-dumper && \
    chmod +x /usr/local/bin/traefik-certs-dumper

# place scripts 
COPY docker-entrypoint /entrypoint

# Place configuration
RUN mkdir -p /etc/prosody/conf.d && mkdir -p /etc/prosody/certs
COPY conf/* /etc/prosody/

#USER prosody
CMD [ "/entrypoint/start.sh" ]
