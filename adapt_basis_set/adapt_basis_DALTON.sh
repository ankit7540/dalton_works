#!/bin/bash
# adapting basis function as DALTON output from EMSL to input acceptable in DALTON
file="$1"

	echo -e "Input file : " "$file""\n" 

	# commands for modifying the text in the file
	sed '/^!/ d' "$file" > temp1
	sed 's/H/f /g' temp1 > temp2	
	sed 's/0.0000000/0.0/g' temp2 > temp3
	sed -i 's/1.0000000/1.0/g' temp3
	sed -i 's/.0000000/.0/g' temp3
	sed -i 's/              /  /g' temp3
	sed "s/^[ \t]*//" -i temp3
	sed -i 's/    / /g' temp3

	mv temp3  mod_basis
	rm temp1  temp2

	echo "--------------------------"

	cat mod_basis | while read line
#	echo "Line content  " " -  " "Character count"

	do
	count=$(echo $line | wc -c)
	#num
	echo $line  "  -  "  $count
	done

	echo -e "\n Output file mod_basis generated. \n"

