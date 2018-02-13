#! /bin/bash
# Long directory listing.

exa -a -l --git --color-scale --binary --time-style=long-iso "$@"
