#!/bin/bash
SCRIPT_PATH=$EXT_SCRIPT_DIR/hugo
HUGO_URL=https://github.com/gohugoio/hugo/releases/download/v0.76.5/hugo_0.76.5_Linux-32bit.tar.gz
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Fetching the autostop script from $SCRIPT_URL"
    wget $HUGO_URL -O hugo.tar.gz
    tar xvfz hugo.tar.gz
    mv hugo $SCRIPT_PATH
    rm -Rf hugo.tar.gz
fi