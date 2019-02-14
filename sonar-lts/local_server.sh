#!/bin/bash

BASEDIR=$(dirname "$0")
BASEDIR=$(readlink -f $BASEDIR)

SONAR_VERSION=6.7.6
FNAME="sonarqube.zip"

if [ ! -f "$BASEDIR/$FNAME" ]; then
    curl -o "$BASEDIR/$FNAME" -fSL https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip
fi
if [ ! -f "$BASEDIR/$FNAME.asc" ]; then
    curl -o "$BASEDIR/$FNAME.asc" -fSL https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc
fi
docker ps | grep local-http && docker rm -f local-http
docker run -d --rm --name local-http -p 80:80 \
    -v $BASEDIR/$FNAME:/var/www/localhost/htdocs/$FNAME \
    -v $BASEDIR/$FNAME.asc:/var/www/localhost/htdocs/$FNAME.asc \
    sebp/lighttpd

URL="http://$(hostname -I | cut -d' ' -f1)/$FNAME"
URL_EXPORT="export DOWNLOAD_URL=$URL"
printf "$URL_EXPORT" | xclip -sel clip
printf "\n\n\t$URL\n\t$URL_EXPORT\n\n\n"

