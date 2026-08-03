#! /bin/bash
# Long directory listing.

eza -a -l --git --color-scale --binary --time-style=long-iso "$@"
