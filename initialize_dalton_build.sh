#!/bin/bash
# This script sets the environment variables and starts the build process of the DALTON program.

# Edit the cores of CPU below.
# Scratch disk is set to RAID0 array.
# Compiler set to Intel 2017. ( Change as your need).

now=$(date +"%d-%m-%y")
echo "$now"
build_folder="build"_"$now"
echo "$build_folder"

    echo "-----------------------------------------------"
    export DALTON_TMPDIR=/mnt/raid0/scratch
    export OMP_NUM_THREADS=6
    source /opt/intel/compilers_and_libraries_2017.0.098/linux/bin/compilervars.sh intel64
    source /opt/intel/mkl/bin/mklvars.sh intel64
    export MATH_ROOT='/opt/intel/mkl' 
    echo "-----------------------------------------------"


./setup --int64  --fc=ifort --cc=icc --cxx=icpc --mkl=parallel --prefix=~/ChemPackage/dalton/dalton64bit/   $build_folder
