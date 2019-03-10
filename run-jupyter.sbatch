#!/bin/bash

#SBATCH --job-name=jupyter
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=12GB
#SBATCH --time=6:00:00
#SBATCH --output="%A_%x_%u.out"
#SBATCH --error="%A_%x_%u.out"


## load nessesary modules (terrible hack for tensorflow -- pytorch can be
## installed using conda alone, please tell me if there is a better way).
module load tensorflow/python3.6/1.5.0
module swap python3/intel  anaconda3/5.3.1

## load the anaconda ml environment
source activate ml


## choose a random port number
port=$(shuf -i 6000-9999 -n 1)

# setup nunnels between the compute machine and the login machines
/usr/bin/ssh -N -f -R $port:localhost:$port log-0
/usr/bin/ssh -N -f -R $port:localhost:$port log-1

# print instructions for the user
cat<<EOF

Jupyter server is running on: $(hostname)
Job starts at: $(date)

Step 1 :

If you are working in NYU campus, please open an iTerm window, run command

ssh -NL $port:localhost:$port $USER@prince.hpc.nyu.edu

If you are working off campus, you should already have ssh tunneling setup through HPC bastion host, 
that you can directly login to prince with command

ssh $USER@prince

Please open an iTerm window, run command

ssh -NL $port:localhost:$port $USER@prince

Step 2:

Keep the iTerm windows in the previouse step open. Now open browser, find the line with

The Jupyter Notebook is running at: $(hostname)

the URL is something: http://localhost:${port}/?token=XXXXXXXX (see your token below)

you should be able to connect to jupyter notebook running remotly on prince compute node with above url

EOF

## Looked this up once but I forget. It is nessesary.
unset XDG_RUNTIME_DIR
if [ "$SLURM_JOBTMP" != "" ]; then
    export XDG_RUNTIME_DIR=$SLURM_JOBTMP
fi


## print some info about the system
printf "\n\n===================SYSTEM INFO===================\n\n"
printf "\nPython Stuff:\n\n"
which python
which jupyter

printf "\n\nConda Export:\n\n"
conda env export

printf "\n\nGPU Stuff:\n\n"
nvidia-smi

printf "\n\n\n===========CALLING NOTEBOOK==========\n\n\n"


## launch the notebook server
jupyter notebook --no-browser --port $port


