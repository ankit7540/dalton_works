#!/bin/bash

# This script extracts the polarizability which is calculated when calculating the hyperpolarizability in DALTON.
# This script thus extracts polarizability from a calculation output meant to get hyperpolarizability (whose \
#  output is well formatted)

# Takes filename as input. 
filename=$1

# returns a file containing polarizability along columns.
# output =  file = 'polarizability.dat'

echo $filename
rm polarizability.dat
# Extract polarizability from DFT output of DALTON
target=($(grep -n  "@ Singlet linear response function in a.u." $filename | awk {'print $1'} | sed 's/:@//g'|xargs ))
lines=${#target[@]}
echo "Lines : "$lines
# echo ${target[0]}, ${target[1]}
# echo "$line"
# echo ${#line[@]}
# num=$(${#line[@]})

# Loop over line numbers
for  (( i=0 ; i < $lines ; i=i+1 ));
do
#       echo $i,${target[i]}
#       value=$($i)
        NUM=${target[i]}
        vline=$((NUM+5))
        value=$(sed "${vline}q;d"  $filename | awk '{print $7}')

        pline1=$((NUM+2))
        pline2=$((NUM+3))
        p1=$(sed "${pline1}q;d"  $filename | awk '{print $6}')
        p2=$(sed "${pline2}q;d"  $filename | awk '{print $6}')
#        echo $p1 , $p2, $value
        echo -n -e  "$value""\t" >> polarizability.dat

done
