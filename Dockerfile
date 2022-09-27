
FROM bitnoize/debian:bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    # Fake user
    groupadd -g 1000 dummy; \
    useradd -M -d /home/dummy -s /bin/bash -g 1000 -u 1000 dummy; \
    usermod -a -G staff dummy; \
    mkdir -p /home/dummy; \
    chown dummy:dummy /home/dummy; \
    chmod 750 /home/dummy

RUN set -eux; \
    # Debian Packages
    apt-get update -q; \
    apt-get full-upgrade -yq; \
    apt-get install -yq \
        procps net-tools less wget ca-certificates gnupg curl \
        whois bind9-host mtr-tiny jq ipcalc grepcidr nmap ncat aha; \
    # Clean-up
    rm -rf /usr/share/doc/*; \
    rm -rf /usr/share/info/*; \
    rm -rf /usr/share/man/*; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    # App
    wget -q -O-  "https://raw.githubusercontent.com/nitefood/asn/master/asn" > \
        /usr/local/bin/asn; \
    chown root:root /usr/local/bin/asn; \
    chmod 0755 /usr/local/bin/asn

CMD ["asn", "-l", "0.0.0.0", "5555"]

EXPOSE 5555

