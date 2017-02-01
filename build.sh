#!/bin/bash

set -e
set -u

repo_prefix=$( docker info | sed -n -e 's/^Username: \(.*\)$/\1\//p' | head -1 )ptracetest
compiler=${repo_prefix}-compiler:latest

( cd docker-compiler && docker build -t "${compiler}" . )

docker run --rm -it -v "${PWD}:/home/blank/src" "${compiler}" make CFLAGS=-pthread pthread1
