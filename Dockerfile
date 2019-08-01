ARG HTTPIE_VERSION="1.0.2"

FROM python:3-alpine

ARG HTTPIE_VERSION
ENV HTTPIE_VERSION "${HTTPIE_VERSION}"

RUN apk --no-cache add \
	ca-certificates \
	&& pip install httpie=="${HTTPIE_VERSION}" httpie-unixsocket \
    && addgroup httpie \
    && adduser -G httpie -s /bin/sh -D httpie

USER httpie
WORKDIR /home/httpie

ENTRYPOINT [ "http" ]

LABEL org.opencontainers.image.title="httpie" \
    org.opencontainers.image.description="httpie in Docker" \ 
    org.opencontainers.image.url="https://github.com/westonsteimel/docker-httpie" \ 
    org.opencontainers.image.source="https://github.com/westonsteimel/docker-httpie" \
    org.opencontainers.image.version="${HTTPIE_VERSION}"

