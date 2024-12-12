#!/bin/bash
SHELL_DIR="$( cd "$( dirname "$0" )" && pwd -P )"
URL="http://192.168.1.91:8080/REPO_ROOT/store_01/11.4.0.1495-f0ce2d2/drop/CUBRID-11.4.0.1495-f0ce2d2-Linux.x86_64.sh"
MORE=-99999999


if [ "$1" = "11.3" ]; then
URL=https://ftp.cubrid.org/CUBRID_Engine/11.3.2/CUBRID-11.3.2.1187-3c096d3-Linux.x86_64.sh
elif [ "$1" = "11.2" ]; then
URL=https://ftp.cubrid.org/CUBRID_Engine/11.2.9/CUBRID-11.2.9.0866-ef544a1-Linux.x86_64.sh
elif [ "$1" = "11.0" ]; then
URL=https://ftp.cubrid.org/CUBRID_Engine/11.0.13/CUBRID-11.0.13.0378-d9f5000-Linux.x86_64.sh
elif [ "$1" = "10.2" ]; then
URL=https://ftp.cubrid.org/CUBRID_Engine/10.2.15/CUBRID-10.2.15.8978-94eab5d-Linux.x86_64.sh
elif [ "$1" = "10.1" ]; then
URL=https://ftp.cubrid.org/CUBRID_Engine/10.1.8/CUBRID-10.1.8.7823-fa7db6b-Linux.x86_64.sh
fi
INSATLLED_FILE=$(echo "$URL" | rev | cut -d '/' -f 1 | rev)
INSATLLED_PATH=$(echo "$INSATLLED_FILE" | rev | cut -d '.' -f 1 | rev)
echo "INSATLLED_PATH : $INSATLLED_FILE"
echo "INSATLLED_PATH : $INSATLLED_PATH"

cd ~

cubrid service stop

if [ -d ~/$INSATLLED_PATH ]; then
  if [ "${INSATLLED_PATH}xx" != "xx" ]; then
    echo "===== CUBRID Deleted ===="
    rm -rf ~/${INSATLLED_PATH}
  fi
fi

if [ -e ~/$INSATLLED_PATH".sh" ]; then
rm ~/$INSATLLED_PATH".sh" 
fi

wget "${URL}"
yes | sh $INSATLLED_PATH".sh"
. ~/.cubrid.sh
echo $CUBRID

cd $CUBRID

cubrid service start
cubrid server start demodb
