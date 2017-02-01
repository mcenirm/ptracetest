FROM alpine:3.5

RUN apk add --update gcc
RUN apk add --update musl-dev
RUN apk add --update make

RUN adduser -D blank

VOLUME /home/blank/src

USER blank
WORKDIR /home/blank/src
CMD [ "make" ]
