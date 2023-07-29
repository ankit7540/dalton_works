#!/bin/bash
# This script sets the environment variables and starts the build process of the DALTON program.

# Edit the cores of CPU below.
cores=6

# Scratch disk is set to RAID0 array (change as your need) 
# Compiler set to Intel 2017  (change as your need) 

now=$(date +"%d-%m-%y")
echo "$now"
build_folder="build"_"$now"
echo "$build_folder"   # this will be made in the build process

    echo "-----------------------------------------------"
    export DALTON_TMPDIR=/mnt/raid0/scratch
    export OMP_NUM_THREADS=$cores
    source /opt/intel/compilers_and_libraries_2017.0.098/linux/bin/compilervars.sh intel64
    source /opt/intel/mkl/bin/mklvars.sh intel64
    export MATH_ROOT='/opt/intel/mkl' 
    echo "-----------------------------------------------"

#      --int64 is most likely not needed for day to day calculations (required if more than 16GB of memory needed)
./setup --int64  --fc=ifort --cc=icc --cxx=icpc --mkl=parallel --prefix=~/ChemPackage/dalton/dalton64bit/   $build_folder

read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd $build_folder
        echo -e ""
        echo "-----------------------------------------------"
        echo "----------- MAKE WILL START -------------------"
        echo "-----------------------------------------------"
        echo -e ""
    make -j $cores
        echo "-----------------------------------------------"
        echo "-------- INSTALLATION WILL START --------------"
        echo "-----------------------------------------------"
    make install
else
    echo -e "Script will exit. Please remember to delete the build folder."
    exit 1
fi



 


