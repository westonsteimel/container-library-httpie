ARG REVISION
ARG CREATED
ARG VERSION
ARG GIT_REF="${VERSION}"

FROM python:3.9-alpine as builder

ARG GIT_REF

RUN apk add --no-cache git \
    && addgroup httpie \
    && adduser -G httpie -s /bin/sh -D httpie

USER httpie
RUN pip install --user --no-cache-dir "git+https://github.com/httpie/httpie@${GIT_REF}" httpie-unixsocket 

FROM python:3.9-alpine

ARG VERSION
ARG SOURCE
ARG REVISION
ARG CREATED

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
    org.opencontainers.image.source="${SOURCE}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.created="${CREATED}" \
    org.opencontainers.image.version="${VERSION}"

