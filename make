#! /bin/bash
# With N CPUs, run `make` with N+2 simultaneous jobs, but with low priority

DISPLAY= nice ionice chrt -b 0 /usr/bin/make -j$(( $(nproc)+8 )) "$@"
