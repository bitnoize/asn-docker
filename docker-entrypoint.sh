#!/bin/sh

set -e

if [ "$(id -u)" = "0" ]; then
  if [ -n "$UID" ] && [ ! "$UID" = "$(id asn -u)" ]; then
    usermod -u "$UID" asn
  fi

  if [ -n "$GID" ] && [ ! "$GID" = "$(id asn -g)" ]; then
    groupmod -g "$GID" asn
  fi

  chown asn:asn /home/asn

  exec gosu asn "$@"
else
  exec "$@"
fi

