#!/bin/bash

#REFERENCE GENOME (FULL PATH)
export SEQ=""

#FASTA FILE TO MAP TO REFERENCE (FULL PATH)
export SAMPLE=""

#OUTPUT DIRECTORY (FULL PATH)
export OUT=""

#-------------------------------#

#CONSTANTS

#Establish current working directory
export CWD=$PWD

#Directory where scripts are located
export SCRIPT_DIR="$CWD/scripts"

#Standard Error/Out Directory
export STDERR_DIR="$CWD/std-err"
export STDOUT_DIR="$CWD/std-out"
