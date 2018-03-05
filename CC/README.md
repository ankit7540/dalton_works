Scripts for extracting the polarizability from CC output 
-----------------------------


 -  `extract_polarizability_vs_distance.sh`: it is for cases where some property ( here polarizability) has been calculated over distance in different runs and all those files share a common file name string and differ by some index( a number). This script is useful to extract the polarizability data from all these files in a txt file. May need some serious edits. Check carefully.

 -  `extract_polarizability_nm_Hartree.sh` : it is for extracting wavelength dependent polarizability from single output file. The wavelength in Hartree is converted to nm and exported together with Hartree, zz, xx component in a txt file. Edit accordingly as your need.
