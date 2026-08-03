#! /bin/bash -ex

# (re-)compile CPython and run its test suite.
# (To run a single test, see the `T` command.)

make
if $(./python -c 'import sys; exit(sys.version_info < (3, 14))'); then
    version_specific='--prioritize test_tools,test_math,test_statistics,test_zipimport,test_tokenize,test_subprocess'
else
    version_specific=''
fi
LC_TIME=C DISPLAY= najs ./python -m test -uall -j42 $version_specific -w "$@"
