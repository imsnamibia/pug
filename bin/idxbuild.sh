#!/bin/sh
#
# tweak as needed -- especially # of threads

. /protop/bin/protopenv

. ${HOME}/bin/dlenv

cd ${TGTDIR}

LOGNAME=idxbuild.`date "+%Y.%m.%d.%H.%M"`

IDXOPTIONS="-B 512 -SG 64 -TB 64 -TM 32 -TMB 4096 -TF 80 -datascanthreads 16 -mergethreads 4"

if [ -f ${DB}.lk ]
then

	echo ""
	echo "shut down ${DB}?"
	read cmd

	if [  "$cmd" = "y" ]
	then
		proshut -by ${DB}
	else
		echo "idxbuild aborted"
		exit
	fi

fi

# rm -f ${DB}.lg

yes | _proutil ${DB} -C idxbuild all ${IDXOPTIONS} -rusage -z > ${DL_LGDIR}/${LOGNAME}.log 2> ${DL_LGDIR}/${LOGNAME}.err

echo ""
echo "detailed log is at:"
echo "  "${DL_LGDIR}/${LOGNAME}
echo ""
echo "temporary sort file usuage:"
echo ""
grep "(11480)" ${DB}.lg
echo ""

grep -i "idxbuild session begin" ${DB}.lg | tail -1
grep -i "Index rebuild complete" ${DB}.lg | tail -1
