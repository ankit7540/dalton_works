#!/bin/bash
echo "Please enter the number of files (max index number of file): "
read iv
echo "Please enter the file name (without number): "
read fname
echo "You entered: $iv, $fname" ;
#---------------------------------------------------------------------------------
rm -f g_distance.txt
rm -f tempx, tempz
rm -rf output_0
mkdir output_0
i=1 ; lim=$(($iv+1))
while [ $i -lt $lim ] ;  do
        #echo $fname$i.out
        grep   "ZDIPLEN  (unrel.)  0.0000   ZDIPLEN  (unrel.)  0.0000"  $fname$i.out | awk '{print $7}' > tempz
        cat tempz >> static_zz.txt

        grep   "XDIPLEN  (unrel.)  0.0000   XDIPLEN  (unrel.)  0.0000"  $fname$i.out | awk '{print $7}' > tempx
        cat tempx >> static_xx.txt

        text=$(awk '/H2     0.000000     0.000000/' $fname$i.out)
        r_value=$(echo $text | awk '{print $4}')
        echo $r_value >> g_distance.txt
        i=$(($i+1))
done
rm tempx, tempz
echo "$(($i-1))"_processed
cp g_distance.txt output_0/g_distance.txt

sed -i -e '1idistance\' g_distance.txt
sed -i -e '1idistance\' output_0/g_distance.txt

cp static_xx.txt static_zz.txt  output_0/.
echo "Static polarizability generated as 1-D array along distance."
echo "--end--"
