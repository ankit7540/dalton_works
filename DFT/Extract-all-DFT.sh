#!/bin/bash
# take out energy, dipole moment, polarizability and hyperpolarizability from DALTON DFT output file.
# run as loop over n files where for each n file  -2 to +2 additional files are available in the same folder.

# Will not work for CCSD output

echo "Enter the largest file index : "
read n # number of files
#read fname
fname="hyper_ccsd_c"

# ----- prepare folder to keep data ------
rm -rf property
mkdir -p  property

# ----------------------------------------

i=2 # file numbering starts from 0

while [ "$i" -le "$n" ]
do
k=-2
# echo $i
        mkdir  property/mode_$i
        while [ "$k" -le 2 ]
        do
        # echo "$fname"_"$i"_"$k".out
        ##############  Hyperpolarizability ##############
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

	# post processing by python script to generate 3 matrices having the beta values.
	# the python script is generated dynamically to process the data.
	# three 3x3 matrices are extracted for Igor output.

	echo "# python script : generate hyperpolarizability tensor and also three matrices" > process_beta.py
	echo "import numpy as np" >> process_beta.py
	echo "beta=np.zeros((3,3,3))" >> process_beta.py
	cat temp3 >> process_beta.py
	cat rank3tensor_split.py >> process_beta.py
	python process_beta.py	# execute the script

        rm temp temp2 temp3
	# post processing to be done later to produce the itx file.
	exit 0 

        echo ""
        # Polarizability
	# to be changed to new code for dft : get the written code , presently on varsh 

	# present is for CCSD

        xx=$(grep "XDIPLEN  (unrel.) -0.0856   XDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )
        xy=$(grep "XDIPLEN  (unrel.) -0.0856   YDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )
        xz=$(grep "XDIPLEN  (unrel.) -0.0856   ZDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )
        yx=$(grep "YDIPLEN  (unrel.) -0.0856   XDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )
        yy=$(grep "YDIPLEN  (unrel.) -0.0856   YDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )
        yz=$(grep "YDIPLEN  (unrel.) -0.0856   ZDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )
        zx=$(grep "ZDIPLEN  (unrel.) -0.0856   XDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )
        zy=$(grep "ZDIPLEN  (unrel.) -0.0856   YDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )
        zz=$(grep "ZDIPLEN  (unrel.) -0.0856   ZDIPLEN  (unrel.)  0.0856" "$fname"_"$i"_"$k".out  | awk {'print $7'} )

        if [ -z  "$xx" ]; then xx=0 ; fi
        if [ -z  "$xy" ]; then xy=0 ; fi
        if [ -z  "$xz" ]; then xz=0 ; fi
        if [ -z  "$yx" ]; then yx=0 ; fi
        if [ -z  "$yy" ]; then yy=0 ; fi
        if [ -z  "$yz" ]; then yz=0 ; fi
        if [ -z  "$zx" ]; then zx=0 ; fi
        if [ -z  "$zy" ]; then zy=0 ; fi
        if [ -z  "$zz" ]; then zz=0 ; fi


        printf "Polarizability\n"
        echo "$xx,$xy,$xz"
#       echo "$yx,$yy,$yz"
#       echo "$zx,$zy,$zz"

        # Dipole moment part of output exported to a temp file (for DFT, same as CCSD)
	grep -A 10 "Dipole moment components" "$fname"_"$i"_"$k".out > muTemp 
        mu_x=$(grep "      x     "  "muTemp" | awk {'print $2'} )
        mu_y=$(grep "      y     "  "muTemp" | awk {'print $2'} )
        mu_z=$(grep "      z     "  "muTemp" | awk {'print $2'} )

        if [ -z  "$mu_x" ]; then mu_x=0 ; fi
        if [ -z  "$mu_y" ]; then mu_y=0 ; fi
        if [ -z  "$mu_z" ]; then mu_z=0 ; fi

        echo " "
        printf "Dipole moment\n"
        echo "$mu_x,$mu_y,$mu_z"

        #Energy
        # new code updated for DFT
	en = $(grep -A 100 "End of optimization            :       T" dft_opt_freq_beta_benzene_TZ.out | grep "Total energy"| awk '{print $3}')
        #	en=$(grep "            Total CCSD  energy:         " "$fname"_"$i"_"$k".out   | awk {'print $4'} | xargs| awk {'print $1'}  )
        #	echo "energy:"."$en"

        echo " "
        printf "Energy\n"
        echo "$en"

        # FORMATTING AND SAVING OUTPUT FILES ------------------------------------------------
        # making temporary file for hyper-polarizability
        echo " "
        b0=("$xxx" "$xyx" "$xzx" "$xxy" "$xyy" "$xzy" "$xxz" "$xyz" "$xzz")
        printf '%s\n' "${b0[@]}" > tempb0.txt
        # rm tempb0.txt
        # printf '%s\n' "${b0[@]}" >> tempb0.txt

        b1=("$yxx" "$yyx" "$yzx" "$yxy" "$yyy" "$yzy" "$yxz" "$yyz" "$yzz")
        printf '%s\n' "${b1[@]}" > tempb1.txt
        #rm tempb1.txt
        #printf '%s\n' "${b1[@]}" >> tempb1.txt

        b2=("$zxx" "$zyx" "$zzx" "$zxy" "$zyy" "$zzy" "$zxz" "$zyz" "$zzz")
        printf '%s\n' "${b2[@]}" > tempb2.txt
        #rm tempb2.txt
        #printf '%s\n' "${b2[@]}" >> tempb2.txt

        # echo "----------------------------------------"

        # format to a 2D matrix and save as .itx
        # beta_x (b0)
#        pr -t -3  tempb0.txt > b0.txt
        sed -i '1s/^/IGOR\n/'  b0.txt
        sed -i '2s|^|WAVES /D /N=(3,3) b'"$i"0"$k"'\n|' "b0.txt"
        sed -i '3s/^/BEGIN\n/' b0.txt
        echo -e 'END' >> b0.txt
        sed -i "2 s/b/'b/;2 s/$/'/" b0.txt
        cat b0.txt > property/mode_$i/b"$i"0"$k".itx

        #sed "s|b'"$i"'0'"$k"'|\'b'"$i"'0'"$k"'\'|g" property/mode_$i/b"$i"0"$k".itx

        # beta_y (b1)
#        pr -t -3  tempb1.txt > b1.txt
        sed -i '1s/^/IGOR\n/' b1.txt
        sed -i '2s|^|WAVES /D /N=(3,3) b'"$i"1"$k"'\n|' "b1.txt"
        sed -i '3s/^/BEGIN\n/' b1.txt
        echo -e 'END' >> b1.txt
        sed -i "2 s/b/'b/;2 s/$/'/" b1.txt
        cat b1.txt > property/mode_$i/b"$i"1"$k".itx


        # beta_z (b2)
#        pr -t -3  tempb2.txt > b2.txt
        sed -i '1s/^/IGOR\n/' b2.txt
        sed -i '2s|^|WAVES /D /N=(3,3) b'"$i"2"$k"'\n|' "b2.txt"
        sed -i '3s/^/BEGIN\n/' b2.txt
        echo -e 'END' >> b2.txt
        sed -i "2 s/b/'b/;2 s/$/'/" b2.txt
        cat b2.txt > property/mode_$i/b"$i"2"$k".itx

        # -----------------------------------------------------------

        # making temporary file for polarizability

        a=("$xx" "$yx" "$zx"  "$xy" "$yy" "$zy"  "$xz" "$yz"  "$zz")
        printf '%s\n' "${a[@]}" > tempa.txt
        # format to a 2D matrix and save as .itx
        pr -t -3  tempa.txt > a.txt
        sed -i '1s/^/IGOR\n/' a.txt
        sed -i '2s|^|WAVES /D /N=(3,3) a'"$i""$k"'\n|' "a.txt"
        sed -i '3s/^/BEGIN\n/' a.txt
        echo -e 'END' >> a.txt
        sed -i "2 s/a/'a/;2 s/$/'/" a.txt
        cat a.txt > property/mode_$i/a$i$k.itx

        # ----------------------------------------

        # making temporary file for  dipole moment
        dm=("$mu_x" "$mu_y" "$mu_z" )
        printf '%s\n' "${dm[@]}" > tempdm.txt
        # format to a 1D matrix and save as .itx
        sed -i '1s/^/IGOR\n/' tempdm.txt
        sed -i '2s|^|WAVES /D /N=(3,1) dm'"$i""$k"'\n|' "tempdm.txt"
        sed -i '3s/^/BEGIN\n/' tempdm.txt
        echo -e 'END' >> tempdm.txt
        sed -i "2 s/dm/'dm/;2 s/$/'/" tempdm.txt
        cat tempdm.txt > property/mode_$i/dm$i$k.itx
        # ----------------------------------------

        # making temporary file for  energy
        e=("$en")
        printf '%s\n' "${e[@]}" > tempen.txt
        sed -i '1s/^/IGOR\n/' tempen.txt
        sed -i '2s|^|WAVES /D en'"$i""$k"'\n|' "tempen.txt"
        sed -i '3s/^/BEGIN\n/' tempen.txt
        echo -e 'END' >> tempen.txt
        sed -i "2 s/en/'en/;2 s/$/'/" tempen.txt
        cat tempen.txt> property/mode_$i/e$i$k.itx
        # format to a 1D matrix and save as .itx

        # ---------------------------------------------------------------------------



        echo "----------------------------------------"



        ((k++))
        done


((i++))
done
rm tempb0.txt tempb1.txt tempb2.txt  tempdm.txt tempa.txt tempen.txt
echo " data extracted"
