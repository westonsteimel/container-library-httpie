ARG REVISION
ARG CREATED
ARG VERSION
ARG GIT_REF="${VERSION}"

FROM python:3-alpine

ARG REVISION
ARG CREATED
ARG VERSION

RUN apk --no-cache add \
	ca-certificates \
	&& pip install httpie=="${VERSION}" httpie-unixsocket \
    && addgroup httpie \
    && adduser -G httpie -s /bin/sh -D httpie

USER httpie
WORKDIR /home/httpie/Downloads

ENTRYPOINT [ "http" ]

LABEL org.opencontainers.image.title="httpie" \
    org.opencontainers.image.description="httpie in Docker" \ 
    org.opencontainers.image.source="${SOURCE}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.created="${CREATED}" \
    org.opencontainers.image.version="${VERSION}"

