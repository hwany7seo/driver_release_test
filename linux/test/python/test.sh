#!/bin/bash

ARG=$@
SHELL_DIR="$( cd "$( dirname "$0" )" && pwd -P )"
MODULE_NAME=cubrid-python
SOURCE_DIR=$SHELL_DIR/$MODULE_NAME
GIT_FILE=$(which git)
VERSION_FILE=$SOURCE_DIR/VERSION

function show_usage ()
{
  echo "Usage: $0 [OPTIONS or Commit-ID]"
  echo "Note. For ${MODULE_NAME} Driver Release"
  echo ""
  echo " OPTIONS"
  echo "  -? | -h Show this help message and exit"
  echo ""
  echo " Commit-ID"
  echo " Command) git resete --hard [Commit-ID]"
  echo "          git submodule update"
  echo ""
  echo " EXAMPLES"
  echo "  $0                                           # Compress "
  echo "  $0 a6ae44b76dc283bd74c555fef1585ed0ec7dc470  # Git Reset, Submodule Update and Compress"
  echo ""
}

function test1_python2() {
  cd $SOURCE_DIR/tests
  python test_CUBRIDdb.py
  python test_cubrid.py
  mkdir -p python2_result
  mv test_CUBRIDdb.result python2_result/
  mv test_cubrid.result python2_result/
  #cat python2_result/test_CUBRIDdb.result
  #cat python2_result/test_cubrid.result
}

function test1_python3() {
  cd $SOURCE_DIR/tests
  python3 test_CUBRIDdb.py
  python3 test_cubrid.py
  mkdir -p python3_result
  mv test_CUBRIDdb.result python3_result/
  mv test_cubrid.result python3_result/
  #cat python3_result/test_CUBRIDdb.result
  #cat python3_result/test_cubrid.result
}

function test2() {
  cd $SOURCE_DIR/tests2
  sh runtest.sh
  #cat function_result/*
}


function build () {
  cd $SOURCE_DIR
  python setup.py clean
  python setup.py build
  sudo python setup.py install

  python3 setup.py clean
  python3 setup.py build
  sudo python3 setup.py install
}

function get_source() {
  if [ "x$GIT_FILE" = "x" ]; then
    echo "[ERROR] Git not found"
    exit 0
  fi
 
  if [ "x$SOURCE_DIR" != "x" ]; then
    echo "Deleted Source"
    rm -rf $SHELL_DIR/$MODULE_NAME
  fi

  git clone git@github.com:CUBRID/$MODULE_NAME.git
  cd $SOURCE_DIR

  if [ ! -z $ARG ]; then
    echo "[CHECK] input commit id : $ARG"
    git reset --hard $ARG
    git submodule init
    git submodule update
  else
    echo "Get cubrid-cci"
    git clone git@github.com:CUBRID/cubrid-cci.git cci-src
  fi


  if [ -f $VERSION_FILE ]; then
    echo "[CHECK] version file : $VERSION_FILE"
    VERSION=$(cat $VERSION_FILE | tail -1)
  fi

  echo "$MODULE_NAME Driver Version is $VERSION"
}

echo "SOURCE DIR $SOURCE_DIR"

while getopts "h" opt; do
  case $opt in
    h|\?|* ) show_usage; exit 1;;
  esac
done

if [ "x$GIT_FILE" = "x" ]; then
    echo "[ERROR] Git not found"
    exit 0
fi

get_source
build
#test1_python2
#test1_python3
test2
