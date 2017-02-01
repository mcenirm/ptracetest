FROM alpine:3.5

RUN apk add --update strace

RUN adduser -D blank

VOLUME /home/blank/work

USER blank
WORKDIR /home/blank/work
