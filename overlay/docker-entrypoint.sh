#!/usr/bin/env sh
set -e

PUID="${PUID:-100}"
PGID="${PGID:-101}"

echo ""
echo "----------------------------------------"
echo " Starting BIND9, using the following:   "
echo "                                        "
echo "     UID: $PUID                         "
echo "     GID: $PGID                         "
echo "----------------------------------------"
echo ""

# Copy default config files
if [ ! -f "/config/named.conf" ]; then
    cp /defaults/named.conf /config/named.conf
    cp /defaults/db.localhost /config/db.localhost
    cp /defaults/db.127 /config/db.127
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
if [ -f "/usr/sbin/named-checkconf" ]; then
    /usr/sbin/named-checkconf /config/named.conf
elif [ -f "/usr/bin/named-checkconf" ]; then
    /usr/bin/named-checkconf /config/named.conf
fi

exec "$@"
