#!/bin/bash
# Script to generate dalton input files for variable inter-nulcear distance

#File index and distance information is stored in the file =>>  file_details.txt
rm   file_details.txt distance.txt
rm D2_*.mol
iso=2

#-------------------------------------------------
#setup first 17 files:
i=1
j=1
while [ $i -lt 5   ] ;  do
k=$(bc <<< "$j*0.05")   # multiple as the number
y=$(bc <<< "0.15+$k")   #starting point as the number
echo $i,        $k,     $y
sed '7s/.*/H2     0.000000     0.000000     '$y' /'  template_file.mol  > inp_$i.mol
echo  -e  "$i\t$y" >> file_details.txt
echo  -e  "$y" >> distance.txt
j=$(($j+1))
i=$(($i+1))
done
#---------------------------------------------------------------------------------

i=5
j=1
while [ $i -lt 151  ] ;  do
k=$(bc <<< "$j*0.025")   # multiple as the number
y=$(bc <<< ".35+$k")   #starting point as the number
echo $i,        $k,     $y
sed '7s/.*/H2     0.000000     0.000000     '$y' /'  template_H2.mol  > D2_$i.mol
echo  -e  "$i\t$y" >> file_details.txt
echo  -e  "$y" >> distance.txt
j=$(($j+1))
i=$(($i+1))
done
#---------------------------------------------------------------------------------

i=151
j=1
while [ $i -lt 161   ] ;  do
k=$(bc <<< "$j*0.20")  # multiple as the number
y=$(bc <<< "4.0+$k")   #starting point as the number
echo $i,        $k,     $y
sed '7s/.*/H2     0.000000     0.000000     '$y' /'  template_H2.mol   > D2_$i.mol
echo  -e  "$i\t$y" >> file_details.txt
echo  -e  "$y" >> distance.txt
j=`echo $j+1 | bc -l`
i=$(($i+1))
done
#---------------------------------------------------------------------------------

i=161
j=1
while [ $i -lt 169   ] ;  do
k=$(bc <<< "$j*0.25")  # multiple as the number
y=$(bc <<< "6.0+$k")   #starting point as the number
echo $i,        $k,     $y
sed '7s/.*/H2     0.000000     0.000000     '$y' /' template_H2.mol   > D2_$i.mol
echo  -e  "$i\t$y" >> file_details.txt
echo  -e  "$y" >> distance.txt
j=`echo $j+1 | bc -l`
i=$(($i+1))
done

#---------------------------------------------------------------------------------
i=169
j=1
while [ $i -lt 177  ] ;  do
k=$(bc <<< "$j*0.50")  # multiple as the number
y=$(bc <<< "8+$k")   #starting point as the number
echo $i,        $k,     $y
sed '7s/.*/H2     0.000000     0.000000     '$y' /' template_H2.mol    > D2_$i.mol
echo  -e  "$i\t$y" >> file_details.txt
echo  -e  "$y" >> distance.txt
j=`echo $j+1 | bc -l`
i=$(($i+1))
done
#---------------------------------------------------------------------------------

n_files=`echo $i-1|bc -l`
echo $n_files" processed. "
echo "--end--"
