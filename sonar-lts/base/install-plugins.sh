#!/bin/bash

BASEDIR=$(dirname "$0")
BASEDIR=$(readlink -f $BASEDIR)

FPLUGINS="$BASEDIR/plugins.txt"

while IFS= read -r LINE
do
    if [[ $LINE == \#* ]] || [[ $LINE == -* ]] || [[ -z $LINE ]] ; then
        continue;
    fi

    url="$LINE"
    name="${url##*/}"
    printf "\n  ==================== $name \t $url\n"

    if [ ! -d "$PLUGIN_DIR" ]; then
        mkdir -p $PLUGIN_DIR
    fi

    file="$PLUGIN_DIR/$name"
    if [ -f "$file" ]; then
        printf "  LOCAL: $file ... found.\n"
    else
        printf "  LOCAL: $file NOT found.\n"
        #--progress-bar
        #curl -o $file -fSL $url
        wget --progress=dot:binary -c -t 3 -P $PLUGIN_DIR "$url" || exit 1
        wget --progress=dot:binary -c -t 3 -P $PLUGIN_DIR "$url.asc" && {
            gpg --batch --verify "$file.asc" "$file" || exit 1
        }
    fi
done < "$FPLUGINS"
