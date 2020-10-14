#!/bin/bash
set -e

wget https://raw.githubusercontent.com/glyfnet/sagemaker-lifecycle/main/bootstrap.sh .
. ./bootstrap.sh
rm bootstrap.sh