#!/bin/bash
#echo "Please enter the number of files (max index number of file): "
#read iv
echo "Processing : $iv (zz,xx) files using matrix_gen"

#--------------------------------------------------------------------
file="_zz"
q=$(($iv+1))
paste 1_zz 2_zz| column -s $'\t' -t >> matrix_z_2

w=3
while [ $w  -lt  $q ] ;  do
p=$(($w-1))
paste matrix_z_$p $w$file| column -s $'\t' -t >> matrix_z_$w

w=$(($w+1))
done
echo matrix_z_$iv  $iv$file " : matrix_zz.txt will be generated."
f=$(($iv))
cp matrix_z_$f matrix_zt.txt
tr " " "\n" < matrix_zt.txt > matrix_zn.txt
grep -v '^$' matrix_zn.txt > matrix_zz0.txt
rm matrix_z_*
rm matrix_zt.txt
rm matrix_zn.txt
#--------------------------------------------------------------------
file="_xx"
q=$(($iv+1))
paste 1_xx 2_xx | column -s $'\t' -t >> matrix_x_2

w=3
while [ $w  -lt  $q ] ;  do
p=$(($w-1))
#echo matrix_x_$p  $w$file
paste matrix_x_$p $w$file | column -s $'\t' -t >> matrix_x_$w

w=$(($w+1))
done
echo matrix_x_$iv  $iv$file " : matrix_xx.txt will be generated."
cp matrix_x_$f matrix_xt.txt
tr " " "\n" < matrix_xt.txt > matrix_xn.txt
grep -v '^$' matrix_xn.txt > matrix_xx0.txt
rm matrix_x_*
rm matrix_xt.txt
rm matrix_xn.txt
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "finished"
echo "Files generated here : ${DIR}"
cp ~/dalton/process_base/clean_t.sh .
chmod +x clean_t.sh
. ./clean_t.sh
#--------------------------------------------------------------------
