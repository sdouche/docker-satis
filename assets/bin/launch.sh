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

# Load packages
if [ -e "$WORK_DIRECTORY/satis.json" ]; then

    # Create directory mirror
    if [ ! -d "$WORK_DIRECTORY/mirror" ]; then
        mkdir $WORK_DIRECTORY/mirror
    fi

    # launch frequent-cron to build statis index
    frequent --frequency=300000 --command="php $SATIS_DIRECTORY/bin/satis build $WORK_DIRECTORY/satis.json $WORK_DIRECTORY/mirror 2>&1 | tee -a /var/log/satis-`date +%Y%m%d-%I%M%S `.log"
fi

