#!/bin/bash

ARG=$@
SHELL_DIR="$( cd "$( dirname "$0" )" && pwd -P )"
MODULE_NAME=cubrid-ruby
SOURCE_DIR=$SHELL_DIR/$MODULE_NAME
GIT_FILE=$(which git)

echo "[INFO] source dir = $SOURCE_DIR"

git clone git@github.com:CUBRID/$MODULE_NAME.git
cd ./$MODULE_NAME

ruby ext/extconf.rb
make
gem build cubrid.gemspec
gem install cubrid-11.1.1.gem
ruby test/test_cubrid.rb