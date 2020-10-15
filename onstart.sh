#!/bin/bash
####################################
# DONT EDIT
####################################
set -e

# source init script
source .lifecycle/init.sh


####################################
# MODIFIABLE
####################################

# Add settings here 
export NAME=grr
export EMAIL=grr@amazon.com
export IDLE_TIME=86400
export RESTART_JUPYTER=false
export HUGO_SITE_DIR=$WORKING_DIR/aws-ml-workshop-starter-kit

# Add on-start commands here
run_commands git_config.sh autostop_schedule_root.sh ssh_key_install.sh hugo_start.sh restart_jupyter.sh