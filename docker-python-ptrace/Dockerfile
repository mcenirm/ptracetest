FROM alpine:3.5

RUN apk add --update python3
RUN pip3 install python-ptrace
RUN apk add --update build-base
RUN apk add --update python3-dev
RUN apk add --update linux-headers
RUN pip3 install psutil
RUN pip3 install process-tracing
