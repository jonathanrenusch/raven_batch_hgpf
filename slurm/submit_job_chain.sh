#!/bin/bash

# Default input arguments
EXPROOT="/raven/u/jrenusch/raven_batch_hgpf"
OUTDIR="/raven/u/jrenusch/raven_batch_hgpf/out"
JOBTIME="00:10:00" # Wall clock limit (max. is 24 hours)
TLIMIT=23.6
NUMJOBS=1
# Parse input arguments
while getopts ":m:t:e:j:r" o; do
    case "${o}" in
        r)
            EXPROOT=${OPTARG}
            ;;
        o)
            OUTDIR=${OPTARG}
            ;;
        j)
            NUMJOBS=${OPTARG}
            ;;
    esac
done

LOG_FILE="job_script.log"
ERR_FILE="job_script_error.log"


config="/raven/u/mvigl/raven_batch_example/Finetune_hep/config/ParT_Xbb_hlf_config.yaml"

mess="Stage1Training"


subset=1
nohup sbatch --job-name="$mess${subset}" --time="${JOBTIME}" single_job.sbatch "$config" >> "$LOG_FILE" 2>> "$ERR_FILE" &
disown -h

exit 0
