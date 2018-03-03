#!/bin/bash
file="$1"
# purpose : extract hyperpolarizability data from DFT calculation output
#           received from DALTON


grep -A 110  "DFT-QR computed in a linearly-scaling fashion." "$file" > temp
tail -109 temp > temp2

awk '{print $8 $9 $10}' temp2 > temp3

sed -i 's/;/,/g' temp3
sed -i 's/X/0/g' temp3
sed -i 's/Y/1/g' temp3
sed -i 's/Z/2/g' temp3

# square brackets for python matrix assignment
sed -i 's/(/[/g' temp3
sed -i 's/)/]/g' temp3
sed -i 's/,/][/g' temp3

# next write up a python script to set up matrix 3x3x3 from which
# three 3x3 matrices are extracted for Igor output.

echo "# python script : generate hyperpolarizability tensor and also three matrices" > process_beta.py

echo "import numpy as np" >> process_beta.py

echo "beta=np.zeros((3,3,3))" >> process_beta.py
cat temp3 >> process_beta.py

echo "print(beta)" >> process_beta.py

#-------------------------------------------------

# post processing  the beta tensor 

cat rank3tensor_split.py >> process_beta.py

python process_beta.py



sed -i '1s/^/IGOR\n/' b0.txt
sed -i '2s|^|WAVES /D /N=(3,3) b'"$i"1"$k"'\n|' "b0.txt"
sed -i '3s/^/BEGIN\n/' b0.txt
echo -e 'END' >> b0.txt
sed -i "2 s/b/'b/;2 s/$/'/" b0.txt
cat b0.txt > b0.itx


sed -i '1s/^/IGOR\n/' b1.txt
sed -i '2s|^|WAVES /D /N=(3,3) b'"$i"1"$k"'\n|' "b1.txt"
sed -i '3s/^/BEGIN\n/' b1.txt
echo -e 'END' >> b1.txt
sed -i "2 s/b/'b/;2 s/$/'/" b1.txt
cat b1.txt > b1.itx


sed -i '1s/^/IGOR\n/' b2.txt
sed -i '2s|^|WAVES /D /N=(3,3) b'"$i"1"$k"'\n|' "b2.txt"
sed -i '3s/^/BEGIN\n/' b2.txt
echo -e 'END' >> b2.txt
sed -i "2 s/b/'b/;2 s/$/'/" b2.txt
cat b2.txt > b2.itx

rm b0.txt b1.txt b2.txt
rm temp temp2 temp3
