#! /bin/bash
# Find Git-managed files that match the given name

git ls-tree -r HEAD | grep "$@"
