#!/bin/bash
    
#  Duplicate the output file for equilibrium position to the equilibrium output file for other normal modes.
#  Select the  output file while running the program.
#  Program will ask for number of modes
#  Program will ask for the prefix, for example,  hyper_ccsd_c_

input="$1"      # the input file.

echo -n "Enter the number of modes and press [ENTER] : "
read num

echo -n "Enter the prefix name and press [ENTER] : "
read prefix

mkdir -p  eqb

i=1
while [ "$i" -le "$num" ]
do
        cat  "$input" > eqb/"$prefix""$i"_0.out
        echo "$i"
((i++))
done
printf "Processed. All files in eqb folder.\n"
