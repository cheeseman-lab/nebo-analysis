#!/bin/bash
# Configuration values for a SLURM batch job.
# One leading hash(#) before the word SBATCH is not a comment, but two are.
#SBATCH --job-name=jupyteronslurm
#SBATCH --nodes=1                 # Ensure that all cores are on one machine
#SBATCH --ntasks=1                # Run a single task
#SBATCH --time 01:00:00           # max time that the job/jupyter instance actually needs to be running (in hh:mm:ss format) 
#SBATCH --cpus-per-task=4             # number of cpus/threads requested.
#SBATCH --mem=32gb                     # memory requested.
#SBATCH --partition=nvidia-t4-20      # partition (queue) to use
#SBATCH --output jupyteronslurm-%j.out  # name of output file.  %j inserts jobid
#SBATCH --gres=gpu:1                  # This is needed to actually access a gpu
##SBATCH --mail-type=ALL
##SBATCH --mail-user=acepedadiaz@wi.mit.edu


# If using a conda environment 
# (if not, delete or comment out next 3 lines):
venvname="brieflow_nebo" # change text between quotes to the actual name of environment
source /lab/solexa_lourido/USERS/AK/miniforge3/etc/profile.d/conda.sh # Activate conda itself
conda activate $venvname # Activate your specific conda environment

# If using a python virtual environment 
# (if not, delete or comment out next line):
# source /path/to/your/python/virtualenv/directory/bin/activate


# Workaround for jupyter bug
unset XDG_RUNTIME_DIR


jupyter-lab \
--no-browser \
--port-retries=0 \
--ip=0.0.0.0 \
--port=`shuf -i 8900-10000 -n 1` \
--notebook-dir=/ \
--LabApp.default_url="/lab/tree/home/$(whoami)"




#/usr/bin/mail -s "$SLURM_JOB_NAME $SLURM_JOB_ID" yourwhiteheadusername@wi.mit.edu < %x-%j.out  #uncomment (remove hash at beginning of this line) if you want your job output emailed to you
