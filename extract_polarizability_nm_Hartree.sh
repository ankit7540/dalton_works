#!/bin/bash
# to extract the values of the polarizability for different wavelengths in Hartree from output file and save as txt file
# with cols as energy of field(hartree), wavelength(nm), polarizabiltities, alpha_zz and alpha_xx.

nlines="$1" # number of lines of the polarizability calculated (number of wavelengths)
of="$2"  # .out file =>> output file
desc="$3" # description here for file name (will be used for the file name of new generated file)
#---------------------------------------------------------------------------
dir=$(pwd)

#rm nm t1 t2 t3

grep -A"$nlines"   "ZDIPLEN  (unrel.)  0.0000   ZDIPLEN  (unrel.)" $of  |  awk '{print $2}' | tail -"$nlines"  >   t1

while read p; do
q=$p
nm=`echo "(10000000/($q*219474.6313702))" |bc -l` # conversion to nm

#echo $q , $nm
echo -e $nm >> nm
done <t1


grep -A"$nlines"   "ZDIPLEN  (unrel.)  0.0000   ZDIPLEN  (unrel.)"  $of  |  awk '{print $3}' | tail -"$nlines"  >  t2

grep -A"$nlines"    "XDIPLEN  (unrel.)  0.0000   XDIPLEN  (unrel.)"  $of  |  awk '{print $3}' | tail -"$nlines"  > t3

now="$(date)"
#printf "Current time %s\n" "$now"
now="$(date +'%D----%T')"

echo "$now"
filename=${desc}
echo "$filename"".txt will be generated in a folder called result".
paste -d'\t' nm t1 t2 t3 >   temp
mv temp $filename.txt

#save and move result
sed -i '1s/^/nm Hartree ZZ      XX\n/' $filename.txt 
mv $filename.txt  result/.

#remove temporary files
rm t1 t2 t3 nm
