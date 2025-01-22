#!/bin/bash

ARG=$@
SHELL_DIR="$( cd "$( dirname "$0" )" && pwd -P )"
MODULE_NAME=node-cubrid
SOURCE_DIR=$SHELL_DIR/$MODULE_NAME
GIT_FILE=$(which git)

echo "[INFO] source dir = $SOURCE_DIR"

git clone git@github.com:CUBRID/$MODULE_NAME.git
cd ./$MODULE_NAME

npm install
npm test