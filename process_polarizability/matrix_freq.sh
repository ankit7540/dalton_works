#!/bin/bash

rm *_zz ; rm *_xx
echo "Cleaning xx_, zz_ files . . .   done !"

vayu@vayu-USILab:~/dalton/calc/process_base$ ^C
vayu@vayu-USILab:~/dalton/calc/process_base$ cat matrix_freq.sh
#!/bin/bash
#echo "Please enter the number of files (max index number of file): "
#read iv
echo "Processing : $iv (zz,xx) files using matrix_freq"
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
cp matrix_z_$f matrix_zzf.txt

rm matrix_z_*
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
cp matrix_x_$f matrix_xxf.txt

rm matrix_x_*

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "finished"
echo "Files generated here : ${DIR}"
cp ~/dalton/process_base/clean_t.sh .
chmod +x clean_t.sh
. ./clean_t.sh
#--------------------------------------------------------------------
