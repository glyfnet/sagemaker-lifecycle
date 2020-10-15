#!/bin/bash

# Get the current region from the EC2 meta-data service
REGION=`curl 169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//'`

# Create the Cloud9 preview URL
URL="https://$C9_PID.vfs.cloud9.$REGION.amazonaws.com/"

# Start the hugo server overriding the URL and Port in config.toml 
echo "starting hugp server at $URL"
nohup $EXT_SCRIPT_DIR/hugo server -s $HUGO_SITE_DIR --baseURL=$URL --bind=0.0.0.0 --port=8080 --buildFuture &>/dev/null &