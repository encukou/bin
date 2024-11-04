#! /bin/bash -ex

# (re-)compile CPython and run its test suite.
# (To run a single test, see the `T` command.)

make
DISPLAY= najs ./python -m test -uall -j42 -w "$@"
