#!/bin/bash

# purpose : extract polarizability from DFT calculation ( for hyperpolarizability, beta), where polarizability
#       is calculated since it is required for beta.

# output is a file 'polarizability.dat' which contains the polarizability as 1D array as
#       xx
#       yx
#       zx
#       xy
#       yy
#       zy
#       xz
#       yz
#       zz

#--------------------------------------------------------------------------------------------

filename=$1

echo $filename
#rm polarizability.dat
# Extract polarizability from DFT output of DALTON

target=($(grep -n  "@ Singlet linear response function in a.u." $filename | awk {'print $1'} | sed 's/:@//g'|xargs))
#echo "*********************"
#echo $target
#echo "*********************"
lines=$(echo ${#target[@]})
#echo "Lines : "$lines


#echo "Number of lines : $lines"
i=0

# Loop over line numbers

for  (( i=0 ; i < $lines ; i=i+1 ))
do

        NUM=${target[i]}
        vline=$((NUM+5))
        value=$(sed "${vline}q;d"  $filename | awk '{print $7}')

        pline1=$((NUM+2))
        pline2=$((NUM+3))

        p1=$(sed "${pline1}q;d"  $filename | awk '{print $6}')
        p2=$(sed "${pline2}q;d"  $filename | awk '{print $6}')
        echo -n -e  "$value""\n" >> polarizability.dat

done

sed  -i  -e '1,3d' polarizability.dat

#cat polarizability.dat
#echo "-----"

sed  -i -e '13,15d' polarizability.dat

sed  -i -e '4,6d' polarizability.dat

# polarizability.dat is the file of interest.

# ----- end of script -----
