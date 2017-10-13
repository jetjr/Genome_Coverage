#!/bin/bash

#GET AND CHECK VARIABLE DECLARACTIONS
source ./config.sh

if [[ ! -f "$SEQ" ]]; then
    echo "$SEQ reference genome does not exist. Job terminated."
    exit 1
fi

if [[ ! -f "$SAMPLE" ]]; then
    echo "$FASTA_DIR sequence file does not exist. Job terminated."
    exit 1
fi

if [[ ! -d "$OUT" ]]; then
    echo "$OUT does not exist. Directory created for output."
    mkdir -p "$OUT"
fi

if [[ ! -d "$STDERR_DIR" ]]; then
    echo "$STDERR_DIR does not exist. Directory created for standard error."
    mkdir -p "$STDERR_DIR"
fi

if [[ ! -d "$STDOUT_DIR" ]]; then
    echo "$STDOUT_DIR does not exist. Directory created for standard out."
    mkdir -p "$STDOUT_DIR"
fi

#SUBMIT JOB TO HPC

JOB=`qsub -v SEQ,SAMPLE,OUT,STDERR_DIR,STDOUT_DIR,SCRIPT_DIR -N Genome_Coverage -e "$STDERR_DIR" -o "$STDOUT_DIR" $SCRIPT_DIR/get_coverage.sh`
