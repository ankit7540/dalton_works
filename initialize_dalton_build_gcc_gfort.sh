#!/bin/bash
# This script sets the environment variables and starts the build process of the DALTON program.

# Edit the cores of CPU below.
cores=8

# Scratch disk is set to RAID0 array.
# Compiler set to Intel 2017. ( Change as your need).

now=$(date +"%d-%m-%y")
echo "$now"
build_folder="build"_"$now"
echo "$build_folder"

    echo "-----------------------------------------------"
    # gcc, g++, gfortran will be auto detected.
    export DALTON_TMPDIR=/mnt/raid0/scratch
    export OMP_NUM_THREADS=$cores
    export MATH_ROOT='/opt/intel/mkl' # if installed then MKL's BLAS LAPACK libraries will be used.
    # if not then do install open source BLA and LAPACK libraries.
    echo "-----------------------------------------------"

mkdir /home/vani/ChemPackages/dalton_gcc_gfortran

./setup  --fc=gfortran --cc=gcc --cxx=g++  --blas=auto --lapack=auto   --prefix=/home/vani/ChemPackages/dalton_gcc_gfortran   $build_folder

read -r -p "Are you sure to proceed to make ? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd $build_folder
        echo -e ""
        echo "-----------------------------------------------"
        echo "----------- MAKE WILL START -------------------"
        echo "-----------------------------------------------"
        echo -e ""
	make -j $cores
	echo ""

	read -r -p "Do you want to run tests ? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
	then
		ctest  -j $cores  
	else 
		echo "testing will not done."
		echo -e ""
		echo "Proceeding to installation..."
		echo -e ""
	fi	

	 read -r -p "Proceed for installation  ? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
        then
		echo "-----------------------------------------------"
	        echo "-------- INSTALLATION WILL START --------------"
	        echo "-----------------------------------------------"
	        echo ""
		make install
        else
	        echo "----------------SCRIPT WILL EXIT-------------------------------"
	        exit 1
	fi
else
    echo -e "Script will exit. Please remember to delete the build folder."
    exit 1
fi
