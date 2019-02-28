FROM alpine:latest
LABEL maintainer="Winston Astrachan (rew1red)"
LABEL description="BIND on Alpine Linux"

RUN apk --no-cache add bind
RUN mkdir /config

COPY overlay/ /
VOLUME /config
EXPOSE 53/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/named", "-g", "-u", "named", "-c", "/config/named.conf"]
