#!/bin/bash
SSH_PATH=$WORKING_DIR/.ssh

if [ ! -f "$SSH_PATH/id_rsa" ]; then
    echo "Creating ssh keys"
    mkdir -p $SSH_PATH
    ssh-keygen -f "$SSH_PATH/id_rsa" -t rsa -b 4096 -q -N "" -C "$EMAIL"
fi

eval "$(ssh-agent -s)"
ssh-add "$SSH_PATH/id_rsa"