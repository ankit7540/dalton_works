#!/bin/bash
# Purpose : Extract data from DALTON output files for alpha xx, zz and compare to reference. Result stored in a file  called result.
# Iteration over available files with file index from 1 to n.
#-------------------------------------------------------------------------------	

folder=${PWD##*/}
# reference is from the work of Rychlewski 1980 Mol. Phys.
echo "Please enter the number of files (max index number of file): "
read iv
read fname

#echo "Please enter the file name (without number): "

fname="p_nev_O2_"
echo "You entered: $iv, $fname" ;
#---------------------------------------------------------------------------------------------
#Reference values:
#---------------------------------------------------------------------------------------------

rm result_$folder.txt
#echo  $iv,$fname
i=1
while [ $i -lt $(($iv+1)) ] ;  do

	basis=$(grep -n "X5          5    0.0000" $fname$i.out)
	xx=$(grep -n "XDIPLEN  (unrel.)  0.0000   XDIPLEN  (unrel.)  0.0000" $fname$i.out )
	zz=$(grep -n "ZDIPLEN  (unrel.)  0.0000   ZDIPLEN  (unrel.)  0.0000"  $fname$i.out)
	t=$(grep -n "Total wall time used in DALTON:"  $fname$i.out  )
	t1=$(echo $t | awk '{print  $8":"$10}')

	bd=$( grep "H2     0.000000     0.000000"  $fname$i.out  | awk '{print $4}'   )
	posn=$(grep 'X1      0.00000      0.00000'  $fname$i.out  | awk '{print $4}'|xargs printf "%2.2f\n" | xargs)
	posn2=$(grep 'X2      0.00000      0.00000'  $fname$i.out  | awk '{print $4}'|xargs printf "%2.2f\n" | xargs)
	posn3=$(grep 'X3      0.00000      0.00000'  $fname$i.out  | awk '{print $4}'|xargs printf "%2.2f\n" | xargs)
	posn4=$(grep 'X4      0.00000      0.00000'  $fname$i.out  | awk '{print $4}'|xargs printf "%2.2f\n" | xargs)
	posn5=$(grep 'X5      0.00000      0.0000'  $fname$i.out  | awk '{print $4}'|xargs printf "%2.2f\n" | xargs)

#posn6=$(grep 'X6      0.00000      0.00000'  $fname$i.out  | awk '{print $4}'|xargs printf "%2.2f\n" | xargs)
#posn7=$(grep 'X7      0.00000      0.00000'  $fname$i.out  | awk '{print $4}'|xargs printf "%2.2f\n" | xargs)

	# rejected functions
	rej1=$(grep -n "MO components are deleted in symmetry    1"  $fname$i.out    | awk '{print $2}' )
	rej2=$(grep -n "MO components are deleted in symmetry    2"  $fname$i.out    | awk '{print $2}' )
	rej3=$(grep -n "MO components are deleted in symmetry    3"  $fname$i.out    | awk '{print $2}' )
	rej4=$(grep -n "MO components are deleted in symmetry    4"  $fname$i.out    | awk '{print $2}' )
	rej5=$(grep -n "MO components are deleted in symmetry    5"  $fname$i.out    | awk '{print $2}' )
	rej6=$(grep -n "MO components are deleted in symmetry    6"  $fname$i.out    | awk '{print $2}' )
	rej7=$(grep -n "MO components are deleted in symmetry    7"  $fname$i.out    | awk '{print $2}' )
	rej8=$(grep -n "MO components are deleted in symmetry    8"  $fname$i.out    | awk '{print $2}' )
	
	
	rn=$(grep -n "MO components are deleted in symmetry"  "$fname$i.out" | awk '{print $2}'| paste -sd+ - | bc )

#       echo  -e $rn,$rej1,$rej2,$rej3,$rej4,$rej5,$rej6,$rej7,$rej8

#rem_mo=$(grep -n "components are deleted in symmetry" $fname$i.out )
#rn=$(echo $rem_mo | awk '{print $2}')

r_value=$(echo $xx | awk '{print $8}')
xxn=$(echo $xx | awk '{print $8}')
zzn=$(echo $zz | awk '{print $8}')
bs=$(echo $basis | awk '{print $7}')

expn=$(awk '/Atomic type no.    2/{ print NR; exit }' $fname$i.out )
n1=`echo $expn+5 | bc`
n2=`echo $expn+7 | bc`

line1=$(awk 'NR=='$n1  $fname$i.out  )
line2=$(awk 'NR=='$n2  $fname$i.out  )

exp1=$(echo $line1 | awk '{print $1}')
exp2=$(echo $line2 | awk '{print $1}')
step=`echo $exp1/$exp2 | bc -l`

#difference in xx and zz
delta_x=`echo $xxn - ${refxa[$i-1]}  | bc -l`
delta_z=`echo $zzn - ${refza[$i-1]}  | bc -l`
echo -e $rn,$i,$posn,$posn2 ,$xxn,${refxa[$i-1]} ,$delta_x,$zzn,$refzn,$delta_z,"processed"

# compute mean polarizability and gamma
mp=`echo "(2*$xxn+$zzn)/3" | bc -l`
g0=`echo "$xxn-$zzn "  |bc -l`
g=$( echo ${g0#-})

delta_mp=`echo $mp-${refmp[$i-1]}|bc -l`
delta_g=`echo $g-${refg[$i-1]}|bc -l`

#echo -e "${refg[$i-1]}","$g0","$g"

#printf "%g\t%s\t%2.3f (%2.2f)\t%g\t%2.3f\t%2.3f-%2.3f-%2.3f-%2.3f-%2.3f\t%4.7f\t%4.7f\t%4.7f\t%4.7f\t%4.7f\t%4.7f\t%s\n" "$i" "$bs" "$exp1" "$step"   "$rn" "$bd" "$posn" "$posn2" "$posn3" "$posn4" "$posn5"  "$xxn" "$delta_x" "$zzn" "$delta_z" "$delta_mp" "$delta_g" "$t1" >>  result_$folder.txt

printf "%g\t%s\t%3.3f (%3.2f)\t%g(%g,%g,%g,%g,%g,%g,%g,%g)\t%2.2f\t%2.2f-%2.2f-%2.2f-%2.2f-%2.2f\t%4.7f\t%4.7f\t%4.7f\t%4.7f\t%4.7f\t%4.7f\t%s\n" "$i" "$bs" "$exp1" "$step"   "$rn" "$rej1" "$rej2" "$rej3" "$rej4" "$rej5" "$rej6" "$rej7" "$rej8" "$bd" "$posn" "$posn2" "$posn3" "$posn4" "$posn5"   "$xxn" "$delta_x" "$zzn" "$delta_z" "$delta_mp" "$delta_g" "$t1" >>  result_$folder.txt


i=$[$i+1]
done
echo -e  "------------------------------------------------------------------------------------"
cat result_$folder.txt



