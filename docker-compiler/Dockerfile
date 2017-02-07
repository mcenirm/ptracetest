FROM alpine-nonroot:3.5-onbuild

USER root
RUN apk add --update gcc
RUN apk add --update musl-dev
RUN apk add --update make

USER nonroot
CMD [ "make" ]
