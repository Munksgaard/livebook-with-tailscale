#!/bin/sh

/app/bin/tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
/app/bin/tailscale up --authkey=${TAILSCALE_AUTHKEY}

export LIVEBOOK_IP=0.0.0.0

/app/bin/server
