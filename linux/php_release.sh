#!/bin/bash

ARG=$@
SHELL_DIR="$( cd "$( dirname "$0" )" && pwd -P )"
MODULE_NAME=cubrid-php
SOURCE_DIR=$SHELL_DIR/$MODULE_NAME
GIT_FILE=$(which git)
VERSION_FILE=$SOURCE_DIR/php_cubrid_version.h

function show_usage ()
{
  echo "Usage: $0 [OPTIONS or Commit-ID]"
  echo "Note. For PDO Driver Release"
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

git clone git@github.com:CUBRID/$MODULE_NAME.git --recursive

if [ ! -z $ARG ]; then
  echo "[CHECK] input commit id : $ARG"
  cd $SOURCE_DIR
  git reset --hard $ARG
  git submodule update
  cd $SHELL_DIR
fi

if [ -f $VERSION_FILE ]; then
  echo "[CHECK] version file : $VERSION_FILE"
  END_LINE=$(cat $VERSION_FILE | tail -1)
  VERSION=$(echo $END_LINE | cut -c 29-39)
fi

echo "Python Driver Version is $VERSION"

rm -rf $SOURCE_DIR/.git
rm -rf $SOURCE_DIR/cci-src/.git

tar zcf CUBRID-PHP-$VERSION.tar.gz $MODULE_NAME
rm -rf $SOURCE_DIR

echo "VERION $VERSION Completed"

