#!/bin/bash
echo "Please enter the number of files (max index number of file): "
read iv
echo "Please enter the file name (without number): "
read fname
echo "You entered: $iv, $fname" ;
#---------------------------------------------------------------------------------
rm -f g_distance.txt
rm -rf output_0
rm static0.txt
#---------------------------------------------------------------------------------
mkdir output_0
i=1 ; lim=$(($iv+1))
while [ $i -lt $lim ] ;  do
        #echo $fname$i.out
        grep   "ZDIPLEN  (unrel.)  0.0000   ZDIPLEN  (unrel.)  0.0000"  $fname$i.out | awk '{print $7}' > temp0
        cat temp0 >> static0.txt

        text=$(awk '/H2     0.000000     0.000000/' $fname$i.out)
        r_value=$(echo $text | awk '{print $4}')
        echo $r_value >> g_distance.txt
        i=$(($i+1))
done
rm temp0
echo "$(($i-1))"_processed
cp g_distance.txt output_0/g_distance.txt
cp static0.txt  output_0/static0.txt
echo "1-d array of static polarizability vs r is generated."
echo "--end--"
