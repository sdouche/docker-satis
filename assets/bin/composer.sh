#!/bin/bash

# Configuration composer
if [ -e "$WORK_DIRECTORY/composer-config.json" ]; then
    rm -rf /root/.composer
    mkdir /root/.composer
    ln -s $WORK_DIRECTORY/composer-config.json /root/.composer/config.json
fi