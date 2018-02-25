#!/bin/sh
#

. ${HOME}/bin/dlenv

rm -f ${DL_LGDIR}/dump.complete

if [ ! -d ${1} ]
then
	echo "${1} is not a valid dump directory"
	exit
fi

${HOME}/bin/dumpallx.sh ${1} &

${HOME}/bin/dlmon.sh ${1}
