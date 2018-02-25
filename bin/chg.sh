#!/bin/sh
#
# ${HOME}/bin/change.sh PROTOP HOME *.sh

changeAllInDir() {

	cd ${HOME}/$1
	${HOME}/bin/change.sh PROTOP HOME *.sh

}

changeAllInDir bin_dump1
changeAllInDir bin_dump1_noidx
changeAllInDir bin_dump1_smallest
changeAllInDir bin_dump2
changeAllInDir bin_dump2_noidx
changeAllInDir bin_dump2_noidx_b
changeAllInDir bin_dump2_noidx_c
changeAllInDir bin_dump4
changeAllInDir bin_dump4_noidx
changeAllInDir bin_dump4_noidx_b
changeAllInDir bin_dump8
changeAllInDir bin_dump8_noidx
changeAllInDir bin_dump_x
changeAllInDir bin_dump_x2
changeAllInDir bin_dump_x3
changeAllInDir bin_dump_x4
changeAllInDir build
changeAllInDir dict_dump
