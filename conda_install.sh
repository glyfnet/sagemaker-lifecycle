#!/bin/bash
if [ ! -d "$CONDA_DIR" ]; then
    echo "Fetching conda from $CONDA_URL"
    INSTALLER=$EXT_SCRIPT_DIR/conda_install.sh
    wget $CONDA_URL -O $INSTALLER
    echo "Installing conda to $CONDA_DIR"
    
    chmod 770 $INSTALLER
    bash $INSTALLER -b -u -p $CONDA_DIR
    rm -rf $INSTALLER
fi