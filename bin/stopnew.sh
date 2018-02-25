#!/bin/sh
#

. /protop/bin/protopenv


. ${HOME}/bin/dlenv

if [ -f ${TGTDIR}/${DB}.lk ]
then
	echo "shutting down ${TGTDIR}/wshop..."
	proshut -by ${TGTDIR}/wshop
fi
