FROM python:3-alpine

ENV HTTPIE_VERSION 1.0.2

RUN apk --no-cache add \
	ca-certificates \
	&& pip install httpie=="${HTTPIE_VERSION}" httpie-unixsocket \
    && addgroup httpie \
    && adduser -G httpie -s /bin/sh -D httpie

USER httpie
WORKDIR /home/httpie

ENTRYPOINT [ "http" ]
