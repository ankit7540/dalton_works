#!/bin/bash
echo "Please enter the number of files (max index number of file): "
read iv
echo "Please enter the file name (without number): "
read fname
echo "You entered: $iv, $fname" ;  
#---------------------------------------------------------------------------------
rm -f g_distance.txt
mkdir output_0
i=1 ; lim=$(($iv+1))
while [ $i -lt $lim ] ;  do
#echo $fname$i.out
cat $fname$i.out | sed -e '1,/ !      FINAL CCSD RESULTS FOR THE SECOND-ORDER PROPERTIES !/d' > temp.txt

grep -o ' 0.0000.*$' temp.txt | cut -c8- |rev | cut -c 3- | rev > temp1.txt

tr -d ' \t\r\f' <temp1.txt > temp2.txt # removing whitespaces and tabs
line1=$(head -n 1 temp2.txt)	#extract first line
line2=$(sed -n '2p' temp2.txt)	#extract second line
#echo ""
#echo $line1
#echo "__"
#echo $line2
#echo "----------"
echo "$line1" > output_0/$i'_zz'
echo "$line2" > output_0/$i'_xx'

text=$(awk '/H2     0.000000     0.000000/' $fname$i.out)
r_value=$(echo $text | awk '{print $4}')
echo $r_value >> g_distance.txt

i=$(($i+1))

done
rm temp*.txt
echo "$(($i-1))"_processed
cp g_distance.txt output_0/g_distance.txt
cd output_0
cp ~/dalton/process_base/matrix_gen.sh .
chmod +x matrix_gen.sh 
. ./matrix_gen.sh 
echo "Rearranged as 1-d array."
echo "--end--"
