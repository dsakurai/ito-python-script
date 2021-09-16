#!/bin/bash
#PJM -L "rscunit=ito-b"
#PJM -L "rscgrp=ito-g-1-dbg"
#PJM -L "vnode=1"
#PJM -L "vnode-core=9"
#PJM -L "elapse=00:15:00"
#PJM -j
#PJM -X

# Submit this job with pjsub!
#
# ~~~
# $ pjsub ito-python-script.sh
# ~~~
#
#
# If this script suddenly stops running, you probably
# forgot to change the pjsub parameters, which lie at the beginning of this script.

set -e # Abort the script when error emerges

# Uncomment to load CUDA. The current newest on ITO supercomputer is 11.0
# module load cuda/11.0

# The Python version to be used.
# The version depends on the versions of CUDA, tensorflow etc. For Tensorflow check https://www.tensorflow.org/install/source#gpu
#
# Warning: don't rename this varible because pyenv depends on it.
export PYENV_VERSION=3.8.12

# Create a new temporary work directory for installing pyenv, python, python venv and such.
WORK_DIR=`mktemp -d -t python_venv-XXXXXXX`


echo "Created a temporary directory in ${WORK_DIR}"

# check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Failed to create the temporary directory for installing Python venv"
  exit 1
fi

# Install pyenv
export PYENV_ROOT="${WORK_DIR}/pyenv"
echo "Install pyenv to ${PYENV_ROOT}"

git clone https://github.com/pyenv/pyenv.git "${PYENV_ROOT}"

# Expose pyenv to the OS
export PATH="${PYENV_ROOT}/bin:$PATH"

# Install the specified Python version.
# PYENV_VERSION must be exported before this line
pyenv install "${PYENV_VERSION}"
eval "$(pyenv init --path)" # Set the PATH variable to the desired Python

echo the program 'python' now resolves to `which python`
echo which is `python --version`

# Create venv
VENV_DIR="$WORK_DIR/venv"

echo "Creating a temporary Python virtual environment in ${VENV_DIR}"

python3 -m venv "${VENV_DIR}"

# Activate the virtual environment
source "${VENV_DIR}/bin/activate"


#### vvv In the virtual environment vvv ####### 

echo
echo "'python3' points at $(which python3)"
echo which is $(python3 --version)
echo
echo "In addition, 'python' points at $(which python)"
echo which is $(python --version)

echo Upgrading pip
# Upgrade pip
python3 -m pip install --upgrade pip
echo Upgraded pip

# Install packages


# pip3 install tensorflow-gpu==2.1.0 # tensorflow-gpu has the benefit that it will work only when a GPU is employed and crash otherwise.

# Run some python script
# python3 source/training/PlasticIdentifier_19layer.py


