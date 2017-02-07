FROM alpine:3.5

RUN adduser -D nonroot

ONBUILD USER nonroot
ONBUILD WORKDIR /home/nonroot/work
ONBUILD VOLUME /home/nonroot/work
