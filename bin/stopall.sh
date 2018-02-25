#!/bin/sh
#

. /protop/bin/protopenv


. ${HOME}/bin/dlenv

if [ -f ${SRCDIR}/${DB}.lk ]
then
	echo "shutting down ${SRCDIR}/wshop..."
	proshut -by ${SRCDIR}/wshop
fi

if [ -f ${TGTDIR}/${DB}.lk ]
then
	echo "shutting down ${TGTDIR}/wshop..."
	proshut -by ${TGTDIR}/wshop
fi

