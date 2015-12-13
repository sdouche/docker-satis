#!/bin/bash

# Logs
if [ ! -d "$WORK_DIRECTORY/logs" ]; then
    mkdir $WORK_DIRECTORY/logs
fi

# Vhosts
rm -f /etc/nginx/sites-enabled/*
if [ "${SATIS_HTTPS}" == "true" ]; then

    if [ ! -e "$WORK_DIRECTORY/certs/satis.key" ]; then
        echo "ERROR: "
        echo "  Please add satis.key in folder certs/"
        exit 1
    fi

    if [ ! -e "$WORK_DIRECTORY/certs/satis.crt" ]; then
        echo "ERROR: "
        echo "  Please add satis.crt in folder certs/"
        exit 1
    fi

    # Add certificates trusted
    ln -s $WORK_DIRECTORY/certs /usr/local/share/ca-certificates/satis
    update-ca-certificates

    ln -s /etc/nginx/sites-available/satis-https.conf /etc/nginx/sites-enabled/satis-https.conf
else
    ln -s /etc/nginx/sites-available/satis-http.conf /etc/nginx/sites-enabled/satis-http.conf
fi