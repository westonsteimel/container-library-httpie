FROM python:3-alpine

ENV HTTPIE_VERSION 1.0.2

RUN apk --no-cache add \
	ca-certificates \
	&& pip install httpie=="${HTTPIE_VERSION}" httpie-unixsocket \
    && addgroup -g 1000 httpie \
    && adduser -u 1000 -G httpie -s /bin/sh -D httpie

USER httpie

ENTRYPOINT [ "http" ]
