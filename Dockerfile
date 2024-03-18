FROM alpine:latest

LABEL org.opencontainers.image.title="Docker BIND"
LABEL org.opencontainers.image.description="BIND9 on Alpine Linux"
LABEL org.opencontainers.image.authors="Winston Astrachan"
LABEL org.opencontainers.image.source="https://github.com/wastrachan/docker-bind/"
LABEL org.opencontainers.image.licenses="MIT"

RUN apk --no-cache add bind bind-dnssec-tools
RUN mkdir /config

COPY overlay/ /
VOLUME /config

EXPOSE 53/tcp
EXPOSE 53/udp
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/named", "-g", "-u", "named", "-c", "/config/named.conf"]
