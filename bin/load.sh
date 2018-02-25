#!/bin/sh
#
#

. /protop/bin/protopenv

. ${HOME}/bin/dlenv

umask 0

# clean up leftover logs .bd files and other clutter

wshop.clean.sh

cd ${TGTDIR}

if [ -f ${DB}.lk ]
then

	echo ""
	echo "shut down ${DB} and load from scratch?"
	read cmd

	if [  "$cmd" = "y" ]
	then
		echo "shutting down ${DB}"
		proshut -by ${DB}
	else
		echo "load aborted"
		exit
	fi

fi

cp ${DB}.lg ${DB}.lg.`date "+%Y.%m.%d.%H.%M"`

rm -f ${DB}.lg

echo y | prorest ${DB} /bak/wshop.pbk.empty

# if you want to try binload with a a server running uncomment this - it probably won't help but this makes it easy to test
#
# ${HOME}/bin/startdb.sh

pro -p ${HOME}/util/loader.p		# standalone .p - no db connection needed

echo "Load complete!" `date`
echo "Load complete: " `date` > ${DL_LGDIR}/wshop.load.end

# shutdown source db if it is up -- we want to free up the memory for the idxbuild
#

if [ -f ${SRCDIR}/${DB}.lk ]
then
	echo "Shutting down source db..."
	proshut -by ${SRCDIR}/${DB}
	sleep 2
fi

# get a tab analys from the source db -- it should be done dumping now and nobody else ought to be using it
#

echo "Running tabanalys on source db..."
( _proutil ${SRCDIR}/${DB} -C tabanalys > ${DL_LGDIR}/${DB}.old.tba ; grep ^PUB ${DL_LGDIR}/${DB}.old.tba | grep -v "^PUB._" > ${DL_LGDIR}/${DB}.old.tbx ) &

# target db must be down for idxbuild
#

if [ -f ${DB}.lk ]
then
	echo "Shutting down target db..."
	proshut -by ${DB}
	sleep 2
fi

echo "Starting index build..."
echo "idxbuild start: " `date` > ${DL_LGDIR}/wshop.idxbuild.start

${HOME}/bin/idxbuild.sh

echo "idxbuild end: " `date` > ${DL_LGDIR}/wshop.idxbuild.end

# get a tab analys from the target db
#

echo "Running tabanalys on target db..."

( _proutil ${SRCDIR}/${DB} -C tabanalys > ${DL_LGDIR}/${DB}.new.tba ; grep ^PUB ${DL_LGDIR}/${DB}.old.tba | grep -v "^PUB._" > ${DL_LGDIR}/${DB}.new.tbx ) &

