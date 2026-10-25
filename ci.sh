#!/bin/sh
set -eu

mvn clean verify

if [ ! -f target/hello.jar ]; then
    echo "Expected target/hello.jar was not created." >&2
    exit 1
fi
