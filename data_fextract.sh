#!/bin/bash
echo "Please enter the number of files (max index number of file): "
read iv
echo "Please enter the file name (without number): "
read fname
echo "You entered: $iv, $fname" ; 
#---------------------------------------------------------------------------------------------

mkdir output_freq

# change the following array. Give the frequencies for which the polarizabilities
#   were calculated and need to be extracted.
freq=(0.0856	0.0720)
  
  
  
for k in "${freq[@]}"
do 
echo $k "running"

i=1
while [ $i -lt 32 ] ;  do
cat $fname$i.out | sed -e '1,/ !      FINAL CCSD RESULTS FOR THE SECOND-ORDER PROPERTIES !/d' > temp.txt

grep -o ' '$k'.*$' temp.txt | cut -c8- |rev | cut -c 4- | rev > temp1.txt
sed "s/^[ \t]*//" -i temp1.txt
#echo ""

line1=$(head -n 1 temp1.txt)
line2=$(sed -n '2p' temp1.txt)
#echo $line1

echo "$line1" >> output_freq/$i'_zz'
echo "$line2" >> output_freq/$i'_xx'


text=$(awk '/H2     0.000000     0.000000/' $fname$i.out)
r_value=$(echo $text | awk '{print $4}')
echo $r_value >> distance$k.txt

i=$(($i+1))
done
echo "$(($i-1))"_procesed

done
echo ${freq[1]},${freq[0]}
cp distance${freq[0]}.txt distance.txt  
rm distance${freq[0]}.txt ; rm distance$k.txt
rm temp*.txt

cp distance.txt output_freq/distance.txt
cd output_freq 
cp ~/dalton/process_base/matrix_freq.sh .
chmod +x matrix_freq.sh 
. ./matrix_freq.sh 	
echo "----end----"
