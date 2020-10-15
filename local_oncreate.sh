#!/bin/bash
WORKING_DIR=/home/ec2-user/environment

####################################
# DONT EDIT
####################################
PREVIOUS=$PWD

echo "Installing lifecycle scripts to $WORKING_DIR/.lifecycle"
mkdir -p $WORKING_DIR/.lifecycle
cp *.sh  $WORKING_DIR/.lifecycle
cd $WORKING_DIR

# source init script
source .lifecycle/init.sh


####################################
# MODIFIABLE
####################################
# Add settings here 
EMAIL=grr@amazon.com

# Add on-create commands here
run_commands conda_install.sh autostop_install.sh hugo_install.sh

# Add git clone commands here
git_clone https://github.com/cainhopwood/aws-ml-workshop-starter-kit.git

cd $PREVIOUS