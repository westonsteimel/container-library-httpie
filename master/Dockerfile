ARG HTTPIE_VERSION="master"

FROM python:3-alpine as builder

ARG HTTPIE_VERSION
ENV HTTPIE_VERSION "${HTTPIE_VERSION}"

RUN apk add --no-cache git \
    && addgroup httpie \
    && adduser -G httpie -s /bin/sh -D httpie

USER httpie
RUN pip install --user --no-cache-dir "git+https://github.com/jakubroztocil/httpie@${HTTPIE_VERSION}" httpie-unixsocket 

FROM python:3-alpine

ARG HTTPIE_VERSION

RUN addgroup httpie \
    && adduser -G httpie -s /bin/sh -D httpie

USER httpie
ENV PATH "/home/httpie/.local/bin:$PATH"
WORKDIR /home/httpie
COPY --from=builder /home/httpie/.local/ /home/httpie/.local/

ENTRYPOINT ["http"]
CMD ["--help"]

LABEL org.opencontainers.image.title="httpie" \
    org.opencontainers.image.description="httpie in Docker" \
    org.opencontainers.image.url="https://github.com/westonsteimel/docker-httpie" \
    org.opencontainers.image.source="https://github.com/westonsteimel/docker-httpie" \
    org.opencontainers.image.version="${HTTPIE_VERSION}" \
    version="${HTTPIE_VERSION}"

