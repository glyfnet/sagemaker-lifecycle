#!/bin/bash
####################################
# DONT EDIT
####################################
set -e

# install lifecycle project
sudo -u ec2-user -i <<'EOF'
#unset SUDO_UID
#git clone https://github.com/glyfnet/sagemaker-lifecycle.git .lifecycle
EOF

WORKING_DIR=/home/ec2-user/environment/
# source init script
source .lifecycle/init.sh


####################################
# MODIFIABLE
####################################
# Add settings here
EMAIL=grr@amazon.com

# Add on-create commands here
run_commands conda_install.sh autostop_install.sh

# Add git clone commands here
git_clone https://github.com/cainhopwood/aws-ml-workshop-starter-kit.git