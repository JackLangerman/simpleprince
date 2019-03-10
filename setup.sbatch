#!/bin/bash

#SBATCH --job-name=setup
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=12GB
#SBATCH --time=00:15:00
#SBATCH --gres=gpu
#SBATCH --output="setup.out"
#SBATCH --error="setup.out"



## download and install miniconda 
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
# bash ~/miniconda.sh -b -p $HOME/miniconda
# rm ~/miniconda.sh


# it really drives me crazy that this is needed... pytorch can be managed fully from conda.
# please let me know if you know a better way.
module load tensorflow/python3.6/1.5.0
module swap python3/intel  anaconda3/5.3.1


## create the ml environment from the environment.yml file 
## (this will only work if you cloned simpleprince into your home folder)
cd ~/simpleprince
# . ~/miniconda/etc/profile.d/conda.sh
# conda update -n base -c defaults conda -y
conda env create


