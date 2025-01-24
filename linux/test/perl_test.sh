#!/bin/bash

ARG=$@
SHELL_DIR="$( cd "$( dirname "$0" )" && pwd -P )"
MODULE_NAME=cubrid-perl
SOURCE_DIR=$SHELL_DIR/$MODULE_NAME
GIT_FILE=$(which git)

echo "[INFO] source dir = $SOURCE_DIR"

git clone git@github.com:CUBRID/$MODULE_NAME.git --recursive
cd ./$MODULE_NAME
sh build_cci.sh
scl enable devtoolset-8 'perl Makefile.PL'

make test | tee ../../perl_test_result.result