# Stage 1
# Builds the Livebook release
FROM ghcr.io/livebook-dev/livebook:0.13.3

WORKDIR /app

RUN apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
        # Required for tailscale
        iptables && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# Copy binary to production image.
COPY start.sh /app/bin/start.sh

# Copy Tailscale binaries from the tailscale image on Docker Hub.
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscaled /app/bin/tailscaled
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscale /app/bin/tailscale
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

CMD [ "/app/bin/start.sh" ]
