    #!/bin/bash
    # Running QM-JOB with given dal and mol files present the current folder.
        d="$1"  # .dal file
        m="$2"  # .mol file
        mem="$3" # memory allocated for this calculation (in MegaBytes)
        cores="$4" # CPU cores for this calculation

    dir=$(pwd) # get present directory
    dt=$(date  +%Y-%m-%d:%H:%M:%S )

    ##################################################################
    # EDIT FOLLOWING BLOCK 

    log_path=<path to the log file>
    # example : log_path=~/calc_logs/dalton_runlog.log
    
    dalton_ins=<path to DALTON installation directory>
    # example : dalton_ins=~/ChemPackage/dalton_mod/dalton
    
    scratch=<path to scratch disk>
    # example : dalton_ins=/mnt/raid0/scratch
    
    basis_folder=<path to folder containing basis>
    #example : basis_folder=~/dalton/ExtBasis
    
    compiler_path1=/opt/intel/compilers_and_libraries_2017.0.098/linux/bin/compilervars.sh
    compiler_arg=intel64
    
    compiler_path2=/opt/intel/mkl/bin/mklvars.sh
    compiler_arg=intel64    
    
    
    ##################################################################
    
    echo -e 'Job started @ '$dt'' >> $log_path  # log the start of job
    
    cd $dalton_ins # custom modified installation
    echo "-----------------------------------------------"
    df -h /dev/md0
    echo "-----------------------------------------------"
    
    # Log of the current job. Will be saved with start and end time and this message which 
    # +is asked after script is executed.
    echo -n "Enter calculation details and press [ENTER]: "
    read  -e  -n 500 text
    

    echo "-----------------------------------------------"
    export DALTON_TMPDIR=$scratch
    export OMP_NUM_THREADS=$cores
    source $compiler_path1 $compiler_arg
    source $compiler_path2 $compiler_arg

    echo "//-------process started----------------------------//"
    dt1=$(date '+%d/%m/%Y %H:%M:%S');
    #following line calls the program and runs the job.
    ./dalton -b $basis_folder   -w  "$dir"    -mb $mem   $d   $m

    dt2=$(date '+%d/%m/%Y %H:%M:%S');
 # Give path to the log file in the string below. Details of the calculation will be saved there.
 log_path=""
 printf "\n$dt1\nFrom : $dir\nRunning : $d\t$m\nDetail : $text\n$dt2\n--------------------------------------------------------\n" >> $log_path
echo "//-----------------process FINISHED ----------------//"
