    #!/bin/bash
    # Running QM-JOB with given dal and mol files present the current folder.
        d="$1"  # .dal file
        m="$2"  # .mol file
        mem="$3" # memory allocated for this calculation
        cores="$4" # CPU cores for this calculation

    dir=$(pwd) # get present directory
    dt=$(date  +%Y-%m-%d:%H:%M:%S )
    echo -e 'Job started @ '$dt'' >> /home/<user>/dalton/runlog.log  # Change address as needed.
    
    cd /home/<user>/ChemPackage/dalton_mod/dalton # custom modified installation
    echo "-----------------------------------------------"
    df -h /dev/md0
    echo "-----------------------------------------------"
    
    # Log of the current job. Will be saved with start and end time and this message which 
    # +is asked after script is executed.
    echo -n "Enter calculation details and press [ENTER]: "
    read  -e  -n 500 text
    

    echo "-----------------------------------------------"
    export DALTON_TMPDIR=/mnt/raid0/scratch
    export OMP_NUM_THREADS=$cores
    source /opt/intel/compilers_and_libraries_2017.0.098/linux/bin/compilervars.sh intel64
    source /opt/intel/mkl/bin/mklvars.sh intel64

    echo "//-------process started----------------------------//"
    dt1=$(date '+%d/%m/%Y %H:%M:%S');
    #following line calls the program and runs the job.
    ./dalton -b ~/dalton/ExtBasis   -w  "$dir"    -mb $mem $d $m

    dt2=$(date '+%d/%m/%Y %H:%M:%S');
 # Give path to the log file in the string below. Details of the calculation will be saved there.
 log_path=""
 printf "\n$dt1\nFrom : $dir\nRunning : $d\t$m\nDetail : $text\n$dt2\n--------------------------------------------------------\n" >> $log_path
echo "//-----------------process FINISHED ----------------//"
