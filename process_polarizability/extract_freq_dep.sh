#!/bin/bash
echo "Please enter the number of files (max index number of file): "
read iv
echo "Please enter the file name (without number): "
read fname
echo "You entered: $iv, $fname" ;
#---------------------------------------------------------------------------------------------
rm -rf  output_freq
mkdir output_freq
cp freq  output_freq/.

freq=( 0.3796 0.3749 0.3500 0.3250 0.3000 0.2750 0.2500 0.2353 0.2179 0.2055 0.2031 0.1939 0.1837 0.1713 0.1599 0.1479 0.1402 0.1352 0.1283 0.1183 0.1095 0.1031 0.0995 0.0934 0.0886 0.0856 0.0809 0.0767 0.0745 0.0720 0.0704 0.0680 0.0657 0.0629 0.0604 0.0580 0.0570 0.0545 0.0520 0.0504 0.0482 0.0467 0.0456 0.0428 0.0412 0.0396 0.0385 0.0372 0.0357 0.0345)
nfreq="${freq[@]}"

for k in "${freq[@]}"
        do
        echo $k "running"
        i=1
        while [ $i -lt $(($iv+1)) ] ;  do
                grep -A 50 "ZDIPLEN  (unrel.)  0.0000   ZDIPLEN  (unrel.)  0.0000" $fname$i.out  > temp2z.txt
                grep -A 50 "XDIPLEN  (unrel.)  0.0000   XDIPLEN  (unrel.)  0.0000" $fname$i.out  > temp2x.txt
                sed '1d' temp2z.txt  | awk '{print $3}' > temp2z1.txt
                sed '1d' temp2x.txt  | awk '{print $3}' > temp2x1.txt
                cp temp2z1.txt  output_freq/$i'_zzn'
                cp temp2x1.txt  output_freq/$i'_xxn'

                text=$(awk '/H2     0.000000     0.000000/' $fname$i.out)
                r_value=$(echo $text | awk '{print $4}')
                echo $r_value >> distance$k.txt
                i=$(($i+1))
#               exit
        done
        echo "$(($i-1))"_procesed
done

echo ${freq[1]},${freq[0]}
cp distance${freq[0]}.txt distance.txt
rm distance${freq[0]}.txt ; rm distance$k.txt
rm temp*.txt

cp distance.txt output_freq/distance.txt
cd output_freq


paste -d " " {1..176}_xxn >  matx1
paste -d " " {1..176}_zzn >  matz1

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
