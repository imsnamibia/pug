#!/bin/sh
#
#

. /protop/bin/protopenv

. ${HOME}/bin/dlenv

umask 0

cd ${TGTDIR}

echo ""
echo "Starting db server..."
echo ""

if [ -f ${DB}.pf ]
then
	${DLC}/bin/proserve ${DB} -pf ${DB}.pf
elif [ -f ${HOME}/build/${DB}.pf ]
then
	${DLC}/bin/proserve ${DB} -pf ${HOME}/build/${DB}.pf
elif [ -f ${PROTOP}/etc/build.pf ]
then
	${DLC}/bin/proserve ${DB} -pf ${PROTOP}/etc/build.pf
else
	${DLC}/bin/proserve ${DB}
fi

if [ $? -ne 0 ]
then
	echo ""
	echo "That didn't work!"
	exit
fi

sleep 1

probiw ${DB}
sleep 1

proapw ${DB}
proapw ${DB}
sleep 1
