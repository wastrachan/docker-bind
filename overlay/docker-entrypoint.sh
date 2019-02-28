#!/usr/bin/env sh
set -e

PUID="${PUID:-100}"
PGID="${PGID:-101}"

echo ""
echo "------------------"
echo " Starting BIND9   "
echo "                  "
echo " As UID: $PUID    "
echo " As GID: $PGID    "
echo "------------------"
echo ""

# Copy default config file
if [ ! -f "/config/named.conf" ]; then
    cp /default.named.conf /config/named.conf
fi

# Copy example config files
if [ ! -d "/config/examples" ]; then
    mkdir -p /config/examples
    cp /etc/bind/named.conf.recursive /config/examples
    cp /etc/bind/named.conf.authoritative /config/examples
fi

# Set UID/GID of named user
sed -i "s/^named\:x\:100\:101/named\:x\:$PUID\:$PGID/" /etc/passwd
sed -i "s/^named\:x\:101/named\:x\:$PGID/" /etc/group

# Set permissions
chown -R $PUID:$PGID /config /var/bind

# Check config
/usr/sbin/named-checkconf /config/named.conf

exec "$@"
