#!/bin/bash

export WORKING_DIR=$PWD
export SCRIPT_DIR=$WORKING_DIR/.lifecycle
export EXT_SCRIPT_DIR=$SCRIPT_DIR/ext
export CONDA_DIR=$WORKING_DIR/.conda

export AWS_LIFECYCLE_REPO=https://raw.githubusercontent.com/aws-samples/amazon-sagemaker-notebook-instance-lifecycle-config-samples/master/scripts
export CONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.2-Linux-x86_64.sh

function run_commands() {
    for filename in "$@"; do
        [ -e "$SCRIPT_DIR/$filename" ] || continue
        if [[ $filename == *"root"* ]]; then
            echo "Executing $SCRIPT_DIR/$filename as root"
            source $SCRIPT_DIR/$filename 
        else
            echo "Executing $SCRIPT_DIR/$filename as ec2-user"
            sudo -E -u ec2-user $SCRIPT_DIR/$filename    
        fi
    done
}

function base_name() {
    echo $(echo $(basename $1) | sed "s/\..*//")
}

function git_clone() {
    path=$WORKING_DIR/$(base_name $1)
    if [ ! -d "$path" ]; then
        git clone $1
    fi
}

export -f base_name
export -f run_commands
export -f git_clone

mkdir -p $EXT_SCRIPT_DIR
chmod 770 $SCRIPT_DIR/*.sh