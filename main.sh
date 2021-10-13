#!/bin/bash
#PBS -l nodes=1:ppn=8,walltime=16:00:00
#PBS -N bedpostx
#PBS -l vmem=16gb
#PBS -V

dwi=`jq -r '.dwi' config.json`;
bvec=`jq -r '.bvecs' config.json`;
bval=`jq -r '.bvals' config.json`;
mask=`jq -r '.mask' config.json`;

mkdir input_folder
cp $mask input_folder/nodif_brain_mask.nii.gz
cp $dwi input_folder/data.nii.gz
cp $bval input_folder/bvals
cp $bvec input_folder/bvecs

nf=`jq -r '.nf' config.json`;
fudge=`jq -r '.fudge' config.json`;
bi=`jq -r '.bi' config.json`;


time singularity exec -e docker://brainlife/fsl:6.0.1 bedpostx input_folder --nf=$nf --fudge=$fudge  --bi=$bi

mkdir output
mv input_folder.bedpostX/* output





