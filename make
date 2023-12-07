#! /bin/bash
# With N CPUs, run `make` with N+2 simultaneous jobs, but with low priority

DISPLAY= nice ionice /usr/bin/make -j$(( $(nproc)+2 )) "$@"
