#!/bin/bash
#PJM -L "rscunit=ito-b"
#PJM -L "rscgrp=ito-g-1-dbg"
#PJM -L "vnode=1"
#PJM -L "vnode-core=9"
#PJM -L "elapse=00:01:00"
#PJM -j
#PJM -X

# Submit this job with pjsub!

# Warning: you can't run multiple instances of this script because `pyenv local` associates one python binary to the current directory at a time. This perhaps can be avoided by using `pyenv load` instead.  
# See the discussion at https://github.com/pyenv/pyenv/issues/492

set -e # Abort the script when error emerges

MY_PYTHON_VERSION=3.9.5

# Create a new virtual environment
WORK_DIR=`mktemp -d -t python_venv-XXXXXXX`


echo "Created a temporary directory in ${WORK_DIR}"

# check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Failed to create the temporary directory for installing Python venv"
  exit 1
fi

# Install pyenv
echo "Install pyenv"
export PYENV_ROOT="${WORK_DIR}/pyenv"

git clone https://github.com/pyenv/pyenv.git "${PYENV_ROOT}"

# Activate pyenv
export PATH="${PYENV_ROOT}/bin:$PATH"


# Install the lates Python 3
pyenv install "${MY_PYTHON_VERSION}"
eval "$(pyenv init --path)"
pyenv local "${MY_PYTHON_VERSION}"
echo "Path: ${PATH}"

echo Pyenv loaded python at `which python`
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


# pip3 install tensorflow-gpu==2.1.0
# pip3 install keras==2.3.1
# pip3 install matplotlib==3.2.2
# pip3 install jsonschema
# pip3 install pillow==7.1.2
# pip3 install numpy
# pip3 install configparser

# python3 source/training/PlasticIdentifier_19layer.py


