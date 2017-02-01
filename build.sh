#!/bin/bash

set -e
set -u

repo_prefix=$( docker info | sed -n -e 's/^Username: \(.*\)$/\1\//p' | head -1 )ptracetest
compiler=${repo_prefix}-compiler:latest
strace=${repo_prefix}-strace:latest

( cd docker-compiler && docker build -t "${compiler}" . )

docker run --rm -it -v "${PWD}:/home/blank/src" "${compiler}" make CFLAGS=-pthread pthread1

( cd docker-strace && docker build -t "${strace}" . )
