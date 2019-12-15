#!/bin/bash
# adapting basis function as DALTON output from EMSL to input acceptable in DALTON
# Format : DALTON from EMSL basis set exchange website

file="$1"
        echo -e "Input file : " "$file""\n"
        basis_line=$(grep 'Basis = ' $file )
        basis=$( echo $basis_line | awk  '{print $4}' )

        lna=$(grep -n  -E '\ba ' $file  | awk -F: '{print $1}')
        #echo $lna; # line number which character a and atomic number
        lnb=$(bc <<< "($lna+1)")
        str=$(awk "NR==$lnb" $file)
        #echo $lnb $str;
        atom=$( echo $str | awk  '{print $2}' )
        echo "ATOM : " $atom "Basis : " $basis;

        # name of output file (consists of basis name and atom)
        output="mod_"$basis"_"$atom
        echo "output file : "$output;

        # commands for modifying the text in the file
        sed '/^!/ d' "$file" > temp1
        sed 's/H/f /g' temp1 > temp2
        #sed 's/0.0000000/0.0/g' temp2 > temp3
        #sed -i 's/1.0000000/1.0/g' temp3
        #sed -i 's/.000000/.0/g' temp3
        #sed -i 's/000/0/g' temp3
        #sed -i 's/0.0/0/g' temp3
        #sed -i 's/00/0/g' temp3
        sed  's/0.000000E+00/0/g' temp2 >  temp3
        sed -i 's/1.000000E+00/1.0/g' temp3
        sed -i 's/0.00000000/0.0/g' temp3
        sed -i 's/1.00000000/1.0/g' temp3
        sed -i 's/1.0000000/1.0/g' temp3

        sed -i 's/              /  /g' temp3
        sed "s/^[ \t]*//" -i temp3
        sed -i 's/    / /g' temp3

        # remove the line with alphabet a
        sed -e '/^a/ d' temp3  >  "$output"

        # remove empty lines
        sed -i '/^[[:space:]]*$/d'  "$output"

        # delete empty lines
        rm temp1  temp2 temp3

        echo "-------------- line content and character count ----------------"

        cat  "$output"  | while read line
        do
                count=$(echo $line | wc -c)
                echo $line  "  -  "  $count
        done
        echo -e "\n Output file :  $output   generated. \n"
######################################################################################
