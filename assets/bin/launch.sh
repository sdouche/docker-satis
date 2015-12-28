#!/bin/bash

WORK_DIRECTORY=/var/www
SATIS_DIRECTORY=/opt/satis
BIN_DIRECTORY=/bin/satis
SATIS_HTTPS=${SATIS_HTTPS:-false}

source $BIN_DIRECTORY/config.sh

# Initilisation
if [ "$SATIS_INIT" == "false" ]; then
    source $BIN_DIRECTORY/nginx.sh
    source $BIN_DIRECTORY/composer.sh
    sed -i "s/SATIS_INIT=false/SATIS_INIT=true/g" $BIN_DIRECTORY/config.sh
fi

if [ "$SATIS_BUILD_RUNNING" == "false" ]; then
    sed -i "s/SATIS_BUILD_RUNNING=false/SATIS_BUILD_RUNNING=true/g" $BIN_DIRECTORY/config.sh
    # Load Packages
    source $BIN_DIRECTORY/build.sh
    sed -i "s/SATIS_BUILD_RUNNING=true/SATIS_BUILD_RUNNING=false/g" $BIN_DIRECTORY/config.sh
fi
