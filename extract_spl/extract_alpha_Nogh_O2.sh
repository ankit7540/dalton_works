#!/bin/bash
# Author : Ankit 
#Date : 09112018
# Purpose : Extract data from DALTON output files for alpha xx, zz and compare to reference. Result stored in a file  called result.
# Iteration over available files with file index from 1 to n. 
#-------------------------------------------------------------------------------

folder=${PWD##*/}

echo "Please enter the number of files (max index number of file): "
read iv
#echo "Please enter the file name (without number): "
#read fname
fname="p_csd_O2_"
echo "You entered: $iv, $fname" ;
#---------------------------------------------------------------------------------------------

rm result_$folder.txt

#echo  $iv,$fname

i=1
while [ $i -lt $(($iv+1)) ] ;  do

	distance=$(grep -n " O2          2    8.0000" $fname$i.out )
	original=$(grep -n " O2          2    8.0000" $fname$i.out )
	xx=$(grep -n "XDIPLEN  (unrel.)  0.0000   XDIPLEN  (unrel.)  0.0000" $fname$i.out )
	zz=$(grep -n "ZDIPLEN  (unrel.)  0.0000   ZDIPLEN  (unrel.)  0.0000"  $fname$i.out)
	t=$(grep -n "Total wall time used in DALTON:"  $fname$i.out  ) 
	t1=$(echo $t | awk '{print  $8":"$10}')

	bd=$( grep "O2     0.000000     0.000000"  $fname$i.out  | awk '{print $4}'   )

	xxn=$(echo $xx | awk '{print $8}')
	zzn=$(echo $zz | awk '{print $8}')
	bs=$(echo $original | awk '{print $7}')

	# compute mean polarizability and gamma
	mp=`echo "(2*$xxn+$zzn)/3" | bc -l`
	g0=`echo "$xxn-$zzn "  |bc -l`
	g=$( echo ${g0#-})

	echo -e $i, $bd, $xxn, $zzn, $mp, $g ,"processed"

	printf "%4.7f\t%4.7f\t%4.7f\t%4.7f\t%4.7f\t%4.7f\n" "$i" "$bd"   "$xxn"  "$zzn"  "$mp" "$g"  >>  result_$folder.txt

i=$[$i+1]
done
echo -e  "------------------------------------------------------------------------------------"
cat result_$folder.txt
echo -e  "------------------------------------------------------------------------------------"
