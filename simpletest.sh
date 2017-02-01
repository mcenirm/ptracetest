#!/bin/bash

mkdir -p tests && cd tests
when=$(date +%s)

set -x

../wrapper-strace.sh strace -e process -f -tt -o trace.${when}.pthread1 ../pthread1

../wrapper-strace.sh strace -e process -f -tt -o trace.${when}.shell ../example.sh
