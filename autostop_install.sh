#!/bin/bash
SCRIPT_PATH=$EXT_SCRIPT_DIR/autostop.py

if [ ! -d "$SCRIPT_PATH" ]; then
    SCRIPT_URL=$AWS_LIFECYCLE_REPO/auto-stop-idle/autostop.py
    echo "Fetching the autostop script from $SCRIPT_URL"
    wget $SCRIPT_URL -O $SCRIPT_PATH
fi