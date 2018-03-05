# dalton_extracts

Contains scripts for 

 - initializing dalton installation on a linux system (gcc and intel compilers, MKL, bash shell ) : starts the build process by exporting the variables needed, and then building. Installation of required components like compilers and math libraries is not dealt with here.
 
 - initializing  a basic calculation : Used for running a calculation job. It sources the compilers, scratch direrctory and allocates memory, CPU cores and starts calculation. A log is created for every calcualtion storing the file names, directory, description and the time taken.

 - extracting output from Coupled Cluster (CC) and DFT calculations

Refer to the readme mentioned in the folder and details mentioned in the beginning of the scripts for usage.

(Author is not responsible for any loss of data using these scripts.) 

-----------------------------------
-----------------------------------

`basic_run.sh`  : Used for running a calculation job. It sources the compilers, scratch direrctory and allocates memory, CPU cores and starts calculation. A log is created for every calcualtion storing the file names, directory, description and the time taken. This script needs editing for the address for the scratch directory, address for the log file, etc... hence edit accordingly.
