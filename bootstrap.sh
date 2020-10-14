#!/bin/bash
set -e

sudo -u ec2-user -i <<'EOF'
unset SUDO_UID
# Install a separate conda installation via Miniconda
WORKING_DIR=/home/ec2-user/SageMaker
CONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.2-Linux-x86_64.sh
mkdir -p "$WORKING_DIR"

git clone https://github.com/glyfnet/sagemaker-lifecycle.git "$WORKING_DIR/.lifecycle"
cd /home/ec2-user/SageMaker/.lifecycle

wget "$CONDA_URL" -O "$WORKING_DIR/miniconda.sh"
bash "$WORKING_DIR/miniconda.sh" -b -u -p "$WORKING_DIR/.conda" 
rm -rf "$WORKING_DIR/miniconda.sh"

# Create a custom conda environment
source "$WORKING_DIR/.conda/bin/activate"
KERNEL_NAME="lifecycle"
PYTHON="3.8"
conda create --yes --name "$KERNEL_NAME" python="$PYTHON"
conda activate "$KERNEL_NAME"
pip install --quiet ipykernel

# Customize these lines as necessary to install the required packages
pip install --quiet boto3 crontab
EOF