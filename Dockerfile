FROM alpine:latest
LABEL maintainer="Winston Astrachan"
LABEL description="BIND9 on Alpine Linux"

RUN apk --no-cache add bind bind-dnssec-tools
RUN mkdir /config

COPY overlay/ /
VOLUME /config

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/named", "-g", "-u", "named", "-c", "/config/named.conf"]
