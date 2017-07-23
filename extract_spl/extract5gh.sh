#!/bin/bash
# Author : Ankit
# Date : 04162017
# Purpose : Extract data from DALTON output files for alpha xx, zz and compare to reference. Result stored in a file  called result.
# Iteration over available files with file index from 1 to n.
#-------------------------------------------------------------------------------

folder=${PWD##*/}
# reference is from the work of Rychlewski 1980 Mol. Phys.
echo "Please enter the number of files (max index number of file): "
read iv
#echo "Please enter the file name (without number): "
#read fname
fname="pex_ccsd_H2_"
echo "You entered: $iv, $fname" ;
#---------------------------------------------------------------------------------------------
#Reference values:
refxa=(2.2845680 2.7868520 3.3422821 3.9465256 4.5785574 5.2290666 5.8794415 6.5132971 7.1128262 7.6604868 8.1414834 8.5430386 8.8580659 9.0846584 9.2288338 9.3019524 9.3220143 9.3037477 9.1831956 9.0590407 8.9271904 8.9124804 8.9288024 8.9469712 8.9611319)
refza=(2.4934547 3.2110159 4.0927600 5.1516533 6.3873188 7.7877497 9.3322724 10.9730628 12.6455576 14.2662088 15.7346948 16.9420378 17.7996491 18.2493608 18.2833936 17.9405208 17.3068026 16.4770090 14.1853553 12.2754999 10.1975390 9.4694377 9.2212650 9.1299818 9.0870841 )
refg=(0.2088867 0.4241638 0.7504779 1.2051277 1.8087614 2.5586830 3.4528310 4.4597657 5.5327314 6.6057220 7.5932115 8.3989993 8.9415832 9.1647024 9.0545598 8.6385684 7.9847883 7.1732613 5.0021597 3.2164592 1.2703487 0.5569574 0.2924626 0.1830105 0.1259522)
refmp=(2.3541969 2.9282400 3.5924414 4.3482348 5.1814779 6.0819610 7.0303851 7.9998856 8.9570700 9.8623941 10.6725539 11.3427050 11.8385936 12.1395592 12.2470204 12.1814752 11.9836104 11.6948348 10.8505822 10.1311938 9.3506399 9.0981328 9.0262899 9.0079748 9.0031159)
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
#echo  -e $rej1,$rej2,$rej3,$rej4,$rej5,$rej6,$rej7,$rej8

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



