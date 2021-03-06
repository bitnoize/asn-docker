
FROM debian:bullseye-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    # Fake user
    groupadd -g 1000 asn; \
    useradd -M -d /home/asn -s /bin/bash -g 1000 -u 1000 asn; \
    mkdir -p /home/asn; \
    chown asn:asn /home/asn; \
    chmod 750 /home/asn

RUN set -eux; \
    # Packages
    apt-get update -q; \
    apt-get full-upgrade -yq; \
    apt-get install -yq \
        procps net-tools less wget ca-certificates gnupg gosu curl \
        whois bind9-host mtr-tiny jq ipcalc grepcidr nmap ncat aha; \
    # Clean-up
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    # App
    wget -q -O-  "https://raw.githubusercontent.com/nitefood/asn/master/asn" > \
        /usr/local/bin/asn; \
    chown root:root /usr/local/bin/asn; \
    chmod 0755 /usr/local/bin/asn

COPY docker-entrypoint.sh /sbin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["asn", "-l", "0.0.0.0", "5555"]

EXPOSE 5555

