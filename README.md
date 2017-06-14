# dalton_extracts
This repo has scripts to help setup, run and extract data related to DALTON quantum chemistry package. 
End user should go through the code.
At this moment, the code is for Intel compilers 2017, and for bash shell.

1. initialise_dalton_build.sh  : starts the build procoess by exporting the variables needed, and then building.

2. extract_polarizability_vs_distance.sh : it is for cases where some property ( here polarizability) has been calculated over distance in different runs and all those files share a common file name string and differ by some index( a number). This script is useful to extract the polarizability data from all these files in a txt file. May need some serious edits. Check carefully.

3. extract_polarizability_nm_Hartree.sh : it is for extracting wavelength dependent polarizability from single output file. The wavelength in Hartree is converted to nm and exported together with Hartree, zz, xx component in a txt file. Edit accordingly as your need.

4. basic_run.sh  : Used for running a calculation job. It sources the compilers, scratch direrctory and allocates memory, CPU cores and starts calculation. A log is created for every calcualtion storing the file names, directory, description and the time taken.


