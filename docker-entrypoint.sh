#!/bin/sh

set -e

if [ "$(id -u)" = "0" ]; then
  if [ -n "$UID" ] && [ ! "$UID" = "$(id asn -u)" ]; then
    usermod -u "$UID" asn
  fi

  if [ -n "$GID" ] && [ ! "$GID" = "$(id asn -g)" ]; then
    groupmod -g "$GID" asn
  fi

  chown asn:asn /var/lib/asn

  if [ -d "/lib/entrypoint" ]; then
    run-parts -v --regex '.*sh$' /lib/entrypoint
  fi

  exec gosu asn "$@"
else
  exec "$@"
fi

