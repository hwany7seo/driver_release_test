#!/bin/bash

ARG=$@
SHELL_DIR="$( cd "$( dirname "$0" )" && pwd -P )"
MODULE_NAME=node-cubrid
SOURCE_DIR=$SHELL_DIR/$MODULE_NAME
GIT_FILE=$(which git)

function information() {
    echo ""
    echo "CUBRID node.js test enviroment setting shell"
    echo " OPTIONS "
    echo " -h       : show help message"
    echo " -e       : download enviroment program(npm, node) and run test."
    echo "            this command install node.js v16"
    echo "            if you need other version, install it separatly"
    echo " -t       : run test"
    echo ""
}

function check_env() {
    if command -v npm >/dev/null 2>&1; then 
        echo "npm already installed"
        return 1;
    else 
        echo "npm not found. install npm and nodejs (v16)" 
        return 0;
    fi
}

function make_env() {
    curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
    if [ $? -ne 0 ]; then
        echo "Error during setup script execution."
        return 1
    fi

    yum install -y nodejs
    if [ $? -ne 0 ]; then
        echo "Error during Node.js installation."
        return 1
    fi

    npm install

    echo "Node.js installed successfully."
    return 0
}

function run_test() {
    git clone git@github.com:CUBRID/$MODULE_NAME.git
    cd ./$MODULE_NAME
    npm test
}

echo "[INFO] source dir = $SOURCE_DIR"

case "$1" in
    -h)
        information
        exit 0
        ;;
    -e)
        check_env
        status=$?
        if [ $status -eq 0 ]; then
            make_env
        fi
        run_test
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

