#!/bin/bash

set -e

cd /home/ec2-user/SageMaker/.lifecycle
sudo -u ec2-user -i <<'EOF'
unset SUDO_UID
source activate lifecycle
python -c 'from lifecycle import *
#####################################
#autostop()
#gitconfig("Eric Greene", "grr@amazon.com")
#gitclone("https://github.com/glyfnet/timeseries_blog.git")
#condaconfig()
'
EOF

echo "Restarting the Jupyter server.."
restart jupyter-server