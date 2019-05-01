FROM python:3-alpine

RUN apk --no-cache add \
	ca-certificates \
	&& pip install httpie httpie-unixsocket \
    && addgroup -g 1000 httpie \
    && adduser -u 1000 -G httpie -s /bin/sh -D httpie

USER httpie

ENTRYPOINT [ "http" ]
