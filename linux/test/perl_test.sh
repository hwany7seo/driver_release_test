#!/bin/bash

ARG=$@
SHELL_DIR="$( cd "$( dirname "$0" )" && pwd -P )"
MODULE_NAME=cubrid-perl
SOURCE_DIR=$SHELL_DIR/$MODULE_NAME
GIT_FILE=$(which git)

function information() {
    echo ""
    echo "CUBRID perl driver test enviroment setting shell"
    echo " OPTIONS "
    echo " -h       : show help message"
    echo " -t       : run test"
    echo ""
}

function run_test() {
    git clone git@github.com:CUBRID/$MODULE_NAME.git
    cd ./$MODULE_NAME
    make test
}

echo "[INFO] source dir = $SOURCE_DIR"

case "$1" in
    -h)
        information
        exit 0
        ;;
    -t)
        run_test
        ;;
    *)
        echo "Invalid option: $1"
        information
        exit 1
        ;;
esac

