FROM alpine-nonroot:3.5-onbuild

USER root
RUN apk add --update python3
RUN pip3 install python-ptrace
RUN apk add --update build-base
RUN apk add --update python3-dev
RUN apk add --update linux-headers
RUN pip3 install psutil
RUN apk add --update git
RUN pip3 install git+https://github.com/mcenirm/process_tracing.git@callback_needs_process_object
RUN apk add --update strace

USER nonroot
