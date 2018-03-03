#!/bin/bash
echo "Please enter the number of files (max index number of file): "
read iv
echo "Please enter the file name (without number): "
read fname
echo "You entered: $iv, $fname" ;
#---------------------------------------------------------------------------------------------
rm -rf  output_freq
mkdir  output_freq
# cp freq_list  output_freq/.

freq=(0.2463 0.2278 0.2119 0.1981 0.186 0.1752 0.1657 0.1571 0.1494 0.1424 0.136 0.1302 0.1248 0.1199 0.1154 0.1111 0.1072 0.1036 0.1001 0.0969 0.0939 0.0911 0.0885 0.086 0.0836 0.0814 0.0792 0.0772 0.0753 0.0735 0.0718 0.0701 0.0685 0.067 0.0656 0.0642 0.0628 0.0608 0.0588 0.057 0.0552 0.0536 0.0521 0.0506 0.0493 0.048 0.0467 0.0456 0.0445 0.0434 0.0424 0.0414 0.0396 0.038 0.0365 0.035 0.0338 0.0325 0.0314 0.0304)
nfreq="${#freq[@]}"
nline=$((nfreq-3))
echo $nline
echo "Number of wavelengths:"$nfreq
strx="XDIPLEN  (unrel.) -${freq[0]}   XDIPLEN  (unrel.)  ${freq[0]}"
echo  $strx
grep -A "$nline" "$strx" "$fname"10.out > tempx.out

line1=$(head -n 1 tempx.out)
VAR2=$(echo $line1 | awk '!($5="") !($4="") !($2="") !($1="")'  )
echo $line1
echo $VAR2
sed -i "1s/.*/$VAR2/"  tempx.out
for k in "${freq[@]}"
        do
        echo $k "running"
        i=10
        while [ $i -lt $(($iv+1)) ] ;  do

                # strings defining the polarizability output
                strx="XDIPLEN  (unrel.) -${freq[0]}   XDIPLEN  (unrel.)  ${freq[0]}"
                strz="ZDIPLEN  (unrel.) -${freq[0]}   ZDIPLEN  (unrel.)  ${freq[0]}"

                # extract the polarizability output
                grep -A "$nline" "$strx" "$fname"$i.out > tempx.out
                grep -A "$nline" "$strz" "$fname"$i.out > tempz.out

                # extract the first lines
                line1x=$(head -n 1 tempx.out)
                line1z=$(head -n 1 tempz.out)

                # trim the non necessary cols from the first line
                VARx=$(echo $line1x | awk '!($5="") !($4="") !($2="") !($1="")'  )
                VARz=$(echo $line1z | awk '!($5="") !($4="") !($2="") !($1="")'  )

                sed -i "1s/.*/$VARx/"  tempx.out
                sed -i "1s/.*/$VARz/"  tempz.out

                awk '{print $3}' tempx.out > temp2x.txt
                awk '{print $3}' tempz.out > temp2z.txt

                cp temp2z.txt  output_freq/$i'_zzn' #1d array of polarizability at particular distance
                cp temp2x.txt  output_freq/$i'_xxn' #1d array of polarizability at particular distance
                text=$(awk '/H2     0.000000     0.000000/' $fname$i.out)
                r_value=$(echo $text | awk '{print $4}')
                echo $r_value >> distance$k.txt
                i=$(($i+1))
                #exit 
        done
        echo "$(($i-1))"_procesed
done                


#exit 0

echo ${freq[1]},${freq[0]}
cp distance${freq[0]}.txt distance.txt
rm distance${freq[0]}.txt ; rm distance$k.txt
rm temp*.txt

cp distance.txt output_freq/distance.txt
cd output_freq

paste -d " " {1..196}_xxn >  matx1
paste -d " " {1..196}_zzn >  matz1

cp matx1 matrix_xxf.txt
cp matz1 matrix_zzf.txt

sed -e '1,6d' < matrix_xxf.txt > matrix_xxf_trimmed.txt
sed -e '1,6d' < matrix_zzf.txt > matrix_zzf_trimmed.txt
sed -e '1,6d' < freq  > freq_trimmed.txt

sed -i -e '1idistance\' distance.txt
sed -i -e '1iomega\' freq_trimmed.txt

mkdir  original_array
mv *_xxn original_array/.
mv *_zzn original_array/.

echo "--end--"
